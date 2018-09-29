import Vue from 'vue/dist/vue.esm'
import rootTable from '../purchase_orders.vue'
import purchaseOrder from '../purchase_order.vue'

window.invoke_render = function() {
  var vm = new Vue({
    el: '#main-container',
    components: {
      rootTable, purchaseOrder
    },
    data: function() {
      return {
        bootstrap: __bootstrap
      }
    }
  })
};
