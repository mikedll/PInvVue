console.log('Hello World from Webpacker');

import Vue from 'vue';
import purchaseOrders from '../purchase_orders.vue';

window.invoke_render = function() {
  var vm = new Vue({
    el: '#main-container',
    components: {
      'root-table': purchaseOrders
    },
    data: {
      message: "Hey mike",
      somePos: __bootstrap
    }
  })
};
