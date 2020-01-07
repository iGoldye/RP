
function numberWithSymbols(x, sym) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, sym);
}

function onEmployeeChangeClick(button) {
	var id = button.getAttribute('data-identifier');
	var newGrade = -1;

	$('select.employee-grade').each(function(){
		if($(this).attr('data-identifier') == id) 
                	newGrade = parseInt($(this).val());
        });

	$.post('http://esx_bossmenu/setGrade', JSON.stringify({
		identifier: id,
		grade: newGrade,
	}));
}

function onSalaryChangeClick(button) {
	var grade = parseInt(button.getAttribute('data-grade'));

	if (isNaN(grade)) {
		return;
	}

	var newSal = -1;

	$('input.salary').each(function(){
		if($(this).attr('data-grade') == grade) 
                	newSal = parseInt($(this).val());
        });

	if (isNaN(newSal) || newSal < 0) {
		return;
	}

	$.post('http://esx_bossmenu/setSalary', JSON.stringify({
		grade: grade,
		amount: newSal,
	}));
}

function onShowMenu(data) {
	document.body.className = "job-"+data.society.job.name;
	$('#logo').attr('src','img/logo/'+data.society.job.name+'.png');

	$('#account-black-money').show()

	if (data.options) {
		if (!data.options.wash) {
			$('#account-black-money').hide()
		}
	}

	$('#container').fadeIn();
	$('#menu').fadeIn();
	$('#deposit_amount').val(data.player.money);
	$('#account-value-cash').text("$"+numberWithSymbols(data.player.money," "));

	$('#withdraw_amount').val(data.society.money);
	$('#account-value-bank').text("$"+numberWithSymbols(data.society.money," "));

	$('#account-value-black').text("$"+numberWithSymbols(data.player.black_money," "));
	$('#account-value-wash').text("$"+numberWithSymbols(data.society.wash_money," "));

	onSetEmployees(data);
	updateSalaries(data.society.job);
	console.log(JSON.stringify(data.society.employees))
}

function updateSalaries(job) {
	var bd = $('#grade-table-body')[0];
	bd.innerHTML = "";
	for (let i = 0; i < job.grades.length; i++) {
		var grade = job.grades[i];

		var row = bd.insertRow();
		var gName = row.insertCell();
		var gSalary = row.insertCell();
		var gAction = row.insertCell();

		var salary_input = document.createElement("input");
		salary_input.value = ""+grade.salary;
		gSalary.appendChild(salary_input);
		salary_input.className = 'salary';
		salary_input.setAttribute('data-grade', i);

		var change_button = document.createElement("button");
		change_button.className = 'salary-apply';
		change_button.setAttribute('data-grade', i);
		change_button.innerHTML = "Применить";
		gAction.appendChild(change_button);

		gName.innerHTML = grade.label;
//		gSalary.innerHTML = "$"+grade.salary;

//		gName.style.width = "350px";
		gSalary.style.width = "5px";
		gAction.style.width = "5px";
	}

	$('button.salary-apply').on('click', function () {
		onSalaryChangeClick(this)
	});

}

function onSetEmployees(data) {
	var bd = $('#employee-table-body')[0];
	bd.innerHTML = "";
	for (let i = 0; i < data.society.employees.length; i++) {
		var e = data.society.employees[i];
//		var ts = new Date(trans.timestamp)

		var newRow = bd.insertRow();
		var cName = newRow.insertCell();
		var cGrade = newRow.insertCell();

		var gradeList = document.createElement("select");
		gradeList.className = "employee-grade";
		gradeList.setAttribute('data-identifier', e.identifier);

		var noopt = document.createElement("option");
		noopt.value = -1;
		noopt.text = "[ Не работает ]";
		gradeList.appendChild(noopt);

		for (let j = 0; j < data.society.job.grades.length; j++) {
			var opt = document.createElement("option");
			opt.value = data.society.job.grades[j].grade;
			opt.text = data.society.job.grades[j].label;
			gradeList.appendChild(opt);
		}

		gradeList.value = e.job.grade;
		cGrade.appendChild(gradeList);

		var cAction = newRow.insertCell();
		cAction.style.textAlign = "center";
/*
		var change_button = document.createElement("button");
		change_button.innerHTML = "Изменить";
		cAction.appendChild(change_button);
		change_button.style.marginRight = "5px";
*/
		var apply_button = document.createElement("button");
		apply_button.setAttribute('data-identifier', e.identifier);
		apply_button.className = "employee-apply";
		apply_button.innerHTML = "Применить";
		cAction.appendChild(apply_button);

		cName.style.width = "300px";
		cAction.style.width = "50px";

		cName.innerHTML = e.name;
//		cGrade.innerHTML = e.job.grade_label || e.job.label;
	}

	$('select').selectric();

	$('button.employee-apply').on('click', function () {
		onEmployeeChangeClick(this)
	});
}

function setPage(page) {
	$('#container-body-balance').hide();
	$('#container-body-employees').hide();
	$('#container-body-salary').hide();

	if (page == "balance")
		$('#container-body-balance').show();
	else if (page == "employees")
		$('#container-body-employees').show();
	else if (page == "salary")
		$('#container-body-salary').show();
}

$(window).ready(function () {
	window.addEventListener('message', function (event) {
		let data = event.data;

		if (data.setemployees) {
			onSetemployees(data);
		} else if (data.showMenu) {
			onShowMenu(data);
		} else if (data.hideAll) {
			$('#container').fadeOut();
		}
	});

	document.onkeyup = function (data) {
		if (data.which == 27 || data.which == 8) {
			$.post('http://esx_bossmenu/escape', '{}');
		}
	};

	$('#container').hide();

	$('#button-balance').on('click', function () {
		setPage("balance");
	})

	$('#button-employees').on('click', function () {
		setPage("employees");
	})

	$('#button-salary').on('click', function () {
		setPage("salary");
	})

	$('#deposit_savings_btn').on('click', function () {
		$.post('http://esx_bossmenu/deposit', JSON.stringify({
			amount: $('#deposit_savings_amount').val(),
			account: 'savings',
		}));

		$('#deposit_savings_amount').val(0);
	})

	$('#deposit_savings_amount').on("keyup", function (e) {
		if (e.keyCode == 13) {
			$.post('http://esx_bossmenu/deposit', JSON.stringify({
				amount: $('#deposit_savings_amount').val(),
				account: 'savings',
			}));

			$('#deposit_savings_amount').val(0);
		}
	});

	$('#deposit_btn').on('click', function () {
		$.post('http://esx_bossmenu/deposit', JSON.stringify({
			amount: $('#deposit_amount').val(),
		}));

		$('#deposit_amount').val(0);
	})

	$('#deposit_amount').on("keyup", function (e) {
		if (e.keyCode == 13) {
			$.post('http://esx_bossmenu/deposit', JSON.stringify({
				amount: $('#deposit_amount').val(),
			}));

			$('#deposit_amount').val(0);
		}
	});

	$('#wash_btn').on('click', function () {
		$.post('http://esx_bossmenu/wash', JSON.stringify({
			amount: $('#wash_amount').val(),
		}));

		$('#wash_amount').val(0);
	});

	$('#hire_btn').on('click', function () {
		$.post('http://esx_bossmenu/hire', JSON.stringify({
		}));
	});

	$('#withdraw_btn').on('click', function () {
		$.post('http://esx_bossmenu/withdraw', JSON.stringify({
			amount: $('#withdraw_amount').val(),
		}));

		$('#withdraw_amount').val(0);
	});

	$('#withdraw_amount').on("keyup", function (e) {
		if (e.keyCode == 13) {
			$.post('http://esx_bossmenu/withdraw', JSON.stringify({
				amount: $('#withdraw_amount').val(),
			}));

			$('#withdraw_amount').val(0);
		}
	});
});
