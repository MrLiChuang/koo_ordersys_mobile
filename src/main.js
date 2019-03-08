// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VueResource from 'vue-resource'
import DrawerLayout from 'vue-drawer-layout'
import touch from 'vue-directive-touch'
import vSelect from 'vue-select'
import { Toast,duration } from 'wc-messagebox'
import 'wc-messagebox/style.css'

Vue.use(Toast, duration);
Vue.component('v-select', vSelect);
Vue.use(touch);
Vue.use(DrawerLayout);
Vue.use(VueResource);
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
