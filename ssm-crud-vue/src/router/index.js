import Vue from 'vue'
import Router from 'vue-router'
import ManagePage from '@/components/ManagePage'
import Index from '@/components/Index'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/ssm-vue',
      name: 'ManagePage',
      component: ManagePage
    },
    {
      path: '/',
      name: 'Index',
      component: Index
    }
  ]
})
