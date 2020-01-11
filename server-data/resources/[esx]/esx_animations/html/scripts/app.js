var currentState = "hide";
var topCells = undefined;

function goBack() {
	if (currentState == "sub" && topCells) {
		onShowMenu(topCells);
	} else {
		$.post('http://esx_animations/escape', '{}');
	}
}

function numberWithSymbols(x, sym) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, sym);
}

function onAnimClicked(elem, shiftKey) {
	if (shiftKey) {
		$.post('http://esx_animations/add-favorite', JSON.stringify({
			value: $(elem).attr('data-value'),
			label: $(elem).attr('data-text'),
		}));
	} else {
		$.post('http://esx_animations/start-anim', JSON.stringify({
			value: $(elem).attr('data-value'),
		}));
	}
}

function onShowSubmenu(menuName, menuLabel, cells) {
	$('#title').text('Анимации – '+menuLabel);

	cells.sort(function(a,b) {
		let va = a.hotkey;
		let vb = b.hotkey;
		return va.localeCompare(vb);
	})

	var t = $('#anim-table');
	t.html('');
	currentState = "sub";

	var celldim = Math.ceil(Math.sqrt(cells.length));
//	var alpha = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ[]-=,./!@#$%^&*()";

	let i = 0;
	for (let x=0; x<celldim; x++) {
		let tr = $('<tr>').appendTo('#anim-table');
		for (let y=0;y<celldim;y++) {
			let cell = cells[i];
			let td = $('<td>').appendTo(tr);

			if (cell) {
//				if (!cell.hotkey) {
//					cell.hotkey = alpha.charAt(i).toString()
//				}

				td.addClass('cell');
				td.css('width', cell.width);
				td.attr('data-type', 'anim');
				td.attr('data-value', cell.value);
				td.attr('data-text', cell.text)
				td.attr('data-hotkey', cell.hotkey);

				let hotkey = $('<div>', {class: 'hotkey'}).text(cell.hotkey).appendTo(td);

				let fav = undefined;
				if (cell.favorite) {
					fav = $('<div>', {class: 'favorite'}).text(cell.favorite).appendTo(td);
					let fav_im =  $('<img>', {width: '20px', src: 'img/icons/fav.png'}).appendTo(fav);
				}

				let icon = $('<img>', {class: 'icon', src: cell.icon}).appendTo(td);
				let text = $('<div>', {class: 'text'}).text(cell.text).appendTo(td);				

				td.on('click', function (e) {
					onAnimClicked(this, e.shiftKey);
				});
			}

			i++;
		}
	}
}

function onShowMenu(cells) {
	cells.sort(function(a,b) {
		let va = a.hotkey;
		let vb = b.hotkey;
		return va.localeCompare(vb);
	})
	$('#title').text('Анимации');

	$('#container').fadeIn('fast');
	var t = $('#anim-table');
	t.html('');
	currentState = "top";
	topCells = cells;

	var celldim = Math.ceil(Math.sqrt(cells.length));

	let i = 0;
	for (let x=0; x<celldim; x++) {
		let tr = $('<tr>').appendTo('#anim-table');
		for (let y=0;y<celldim;y++) {
			let cell = cells[i];
			let td = $('<td>').appendTo(tr);

			if (cell) {
				td.addClass('cell');
				td.css('width', cell.width);
				td.attr('data-type', 'animmenu');
				td.attr('data-value', cell.value);
				td.attr('data-text', cell.text)
				td.attr('data-hotkey', cell.hotkey);

				let hotkey = $('<div>', {class: 'hotkey'}).text(cell.hotkey).appendTo(td);

				let fav = undefined;
				if (cell.favorite) {
					fav = $('<div>', {class: 'favorite'}).text(cell.favorite).appendTo(td);
					let fav_im =  $('<img>', {width: '20px', src: 'img/icons/fav.png'}).appendTo(fav);
				}

				let icon = undefined;
				if (cell.icon) {
					icon = $('<img>', {class: 'icon', src: cell.icon}).appendTo(td);
				}

				let text = $('<div>', {class: 'text'}).text(cell.text).appendTo(td);

				td.on('click', function () {
					let submenu = $(this).attr('data-value');
					let sublabel = $(this).attr('data-text');
					let subcells = cell.cells;
					onShowSubmenu(submenu, sublabel, subcells);
				});
			}

			i++;
		}
	}
}

$(window).ready(function () {
	window.addEventListener('message', function (event) {
		let data = event.data;

		if (data.showMenu) {
			onShowMenu(data.options.cells);
		} else if (data.hideAll) {
			$('#container').fadeOut('fast');
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27 || data.which == 8) {
			goBack();
		}

		$('.cell').each(function(index) {
			var hotkey = $(this).attr('data-hotkey').toLowerCase();
			var dtype = $(this).attr('data-type').toLowerCase();
			if (data.key == hotkey) {
				if (dtype == "anim") {
					onAnimClicked(this, data.shiftKey);
				} else {
					$(this).click();
				}
				return false;
			}
		});
	};

	document.onmousedown = function (data) {
		var rightclick = false;
		if (data.which) rightclick = (data.which == 3);
		else if (data.button) rightclick = (data.button == 2);
		if (rightclick) {
			goBack();
		}
	}

	$('#container').hide();

});
