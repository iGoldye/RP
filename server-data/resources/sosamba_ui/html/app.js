Vue.component('pipe-meter-vert', {
  props: ['value','hue','width','height'],
  template: `<div class="pipe-meter-container"
                 v-bind:style="{'background': 'linear-gradient(to right,  hsl('+hue+', 100%, 41%) 0%, hsl('+hue+', 100%, 55%) 50%, hsl('+hue+', 100%, 41%) 100%)',
                                'border-color': 'hsl('+hue+', 45%, 27%)',
                                'width': width+'px',
                                'height': height+'px'
                               }">
                 <div class="pipe-meter-value"
                     v-bind:style="{'height': (1-value)*100+'%',
				    'background': 'linear-gradient(to right,  hsl('+hue+', 100%, 21%) 0%, hsl('+hue+', 100%, 10%) 50%, hsl('+hue+', 100%, 21%) 100%)'
                                   }">
                 </div>
                 <div class="pipe-meter-label"
                 ><slot></slot></div>
            </div>`
})

var app = new Vue({
	el: "#app",
	data: {
		"hunger": 0,
		"thirst": 0,
		"paused": true
	}
});

window.onData = (data) => {
	switch (data.action) {

		case 'setNeeds': {
			app.hunger = data.hunger;
			app.thirst = data.thirst;
			break;
		}

		case 'setPause': {
			app.paused = data.paused;
			break;
		}

		case 'setWebsite': {
			var container = document.getElementById("website-container");
			var frame = document.getElementById("website-frame");

			if (data.url) {
				container.style.display = "block";
				frame.src = data.url;
			} else {
				container.style.display = "none";
				frame.src = "";
			}

			break;
		}
	}
};

window.onload = function (e) {
	window.addEventListener('message', (event) => {
		onData(event.data);
	});
};
