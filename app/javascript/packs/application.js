import Vue from 'vue/dist/vue.esm.js';
import rootTable from '../purchase_orders.vue';


window.invoke_render = function() {
  var vm = new Vue({
    el: '#main-container',
    components: {
      rootTable
    },
    data: {
      somePos: __bootstrap
    }
  })
};
