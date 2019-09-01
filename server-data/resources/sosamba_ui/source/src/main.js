import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';

Vue.config.productionTip = false;

Vue.prototype.$eventHub = new Vue();
Vue.prototype.console = console;

var vue = new Vue({
  vuetify,
  render: h => h(App),
  renderError (h, err) {
    return h('pre', { style: { color: 'red' }}, err.stack)
  },
}).$mount('#app')

//var app = vue.$children[0];

window.addEventListener( 'touchmove', function() {})

document.addEventListener('keydown', function(event) {
  vue.$eventHub.$emit('key_down', event);
});

window.onload = function () {

  window.addEventListener('message', (event) => {
    vue.$eventHub.$emit('message', event.data);
  });
}

window.post = function(url, data) {
  var xhr = new XMLHttpRequest();
  xhr.open("POST", url, true);
//  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      this.console.log("HTTP status: "+this.status);
    }
  };

  if (!data) {
    xhr.send();
  } else {
    xhr.send(data);
  }
//  xhr.send(encodeURIComponent(data));
};

