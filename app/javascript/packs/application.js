import Vue from 'vue/dist/vue.esm'
import appHome from '../purchase_orders.vue'
import purchaseOrder from '../purchase_order.vue'

window.invoke_render = function() {
  var vm = new Vue({
    el: '#main-container',
    components: {
      appHome, purchaseOrder
    },
    data: function() {
      return {
        bootstrap: __bootstrap
      }
    }
  })
};
