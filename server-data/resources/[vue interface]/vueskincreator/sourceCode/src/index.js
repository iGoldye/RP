//libs
import Vue from "vue";
//components
import App from "./components/SkinCreator";
// core
import "./js/index";
import "./scss/main.scss";

new Vue({
  el: "#app",
  render: h => h(App)
});
