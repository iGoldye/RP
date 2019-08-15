//libs
import Vue from "vue";
//components
import App from "./components/Register";
import Vuelidate from "vuelidate";
Vue.use(Vuelidate);
// core
import "./js/index";
import "./scss/main.scss";

new Vue({
  el: "#app",
  render: h => h(App)
});
