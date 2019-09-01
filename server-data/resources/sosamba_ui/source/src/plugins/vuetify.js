//import '@mdi/font/css/materialdesignicons.css'
import Vue from 'vue';
import Vuetify from 'vuetify/lib';

Vue.use(Vuetify);

export default new Vuetify({
  icons: {
    iconfont: 'mdiSvg',
  },
  //theme: { disable: true },
  
  theme: {
    themes: {
      light: {
        primary: '#169ab1',
        secondary: '#f44336',
        accent: '#8bc34a',
        error: '#ff5722',
        warning: '#ffc107',
        info: '#009688',
        success: '#4caf50',
      },
    },
  },

});
