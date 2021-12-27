// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import './plugins/element.js'
import store from './store'
import VueCookies from 'vue-cookies'
import global from "./lib/global";


var echarts = require("echarts");


Vue.use(VueCookies)

Vue.prototype.$global = global;
Vue.prototype.$echarts = echarts;
Vue.config.productionTip = false;
global.syncInfoOnRefresh();

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: {App},
  store,
  template: '<App/>'
})
