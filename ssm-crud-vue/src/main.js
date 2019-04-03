import Vue from 'vue'
import router from './router'
import ElementUI from 'element-ui'//添加新行
import 'element-ui/lib/theme-chalk/index.css'//添加新行
import axios from 'axios'

import App from './App'

Vue.use(ElementUI);//添加新行
Vue.prototype.$axios = axios
axios.defaults.timeout = 10000;// 在超时前，所有请求都会等待 10 秒
// 配置请求头
axios.defaults.headers.post['Content-Type']='application/x-www-form-urlencoded;charset=UTF-8';
axios.defaults.baseURL = 'http://47.107.228.248:8080/ssmcrud/';// 配置接口地址
// axios.defaults.baseURL = 'http://localhost:8080/';// 配置接口地址
axios.defaults.withCredentials = false;
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
