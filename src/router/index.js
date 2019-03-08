import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/login/Login'
import Home from  '@/components/home/Home'
import Drawer from  '@/components/drawer/Drawer'
import Bill from  '@/components/bill/Bill'
import Deliver from  '@/components/deliver/Deliver'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/home',
      component: Home
    },
    {
      path: '/drawer',
      component: Drawer
    },
    {
      path: '/bill',
      component: Bill
    },
    {
      path: '/deliver',
      component: Deliver
    }
  ]
})
