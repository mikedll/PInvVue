<template>
  <div className="line_items">
    <div><strong> Line Items </strong></div>

    <line-item-form></line-item-form>
    
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Qty</th>        
          <th>Price</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <line-item-row v-on:li-deleted="handleLineItemDelete" v-for="li in m_line_items" :line_item="li" :key="li.id"></line-item-row>
        <tr>
          <td colspan="2">Total:</td>
          <td><strong>{{ m_total }}</strong></td>
          <td></td>
        </tr>
      </tbody>
    </table>    
  </div>
</template>

<script>
import update from 'immutability-helper'
import _ from 'underscore'
import lineItemForm from 'line_item_form.vue'
import lineItemRow from 'line_item_row.vue'

export default {
  props: ['total', 'line_items', 'purchase_order_id'],
  components: {
    lineItemForm, lineItemRow
  },
  data: function() {
    return {
      m_total: this.total,
      m_line_items: this.line_items
    }
  },
  methods: {
    handleSubmit: function() {
      $.ajax({
        method: 'POST',
        url: '/purchase_orders/' + this.purchase_order.id + '/line_items',
        dataType: 'JSON',
        data: {
          quantity: 1,
          added_at: null,
          item_id: null
        },
        success: (data) => {
          this.m_line_items = update(this.m_line_items, {$push: [_.omit(data, 'purchase_order')]})
          this.m_total = data.purchase_order.total
        }
      })
    },
    handleLineItemDelete: function(params) {
      var index = this.m_line_items.indexOf(params.line_item)
      this.m_line_items = update(this.m_line_items, { $splice: [[index, 1]] } )
      this.m_total = params.purchase_order.total
      return
    }
  }
}
</script>
