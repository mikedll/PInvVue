<template>
<tr>
  <template v-if="!editMode">
    <td>{{ fAddedAt }}</td>
    <td>{{ item.name }}</td>
    <td>{{ fUnitPrice }}</td>
    <td>{{ quantity }}</td>
    <td>{{ fPrice }} </td>
    <td>
      <button v-on:click="handleEdit">Edit</button>      
      <button v-on:click="handleDelete">Delete</button>
    </td>
  </template>
  <template v-else>
    <td><input type="text" name="added_at" v-model="added_at"/></td>
    <td><input type="text" name="item_search" :value="item.name"/></td>
    <td>{{ item.unit_price }}</td>
    <td><input type="text" v-model="quantity"/></td>
    <td>{{ newPrice }}</td>
    <td>
      <button v-on:click="handleUpdate">Update</button>      
      <button v-on:click="handleCancel">Cancel</button>
    </td>
  </template>
</tr>
</template>

<script>
import moment from 'moment'
import { AppRoutes } from 'support/appRoutes.js'
import { amountFormat, MomentFormats } from 'support/utils.coffee'
import { LineItem } from 'support/line_item.coffee'

export default {
  props: ['line_item'],
  data: function() {
    return {
      bound: false,
      editMode: false,
      added_at: this.line_item.added_at,
      quantity: this.line_item.quantity,
      item: this.line_item.item,
      item_id: this.line_item.item_id,
      unit_price: this.line_item.unit_price
    }
  },
  computed: {
    newPrice: function() {
      const li = new LineItem(this.item, this.quantity)
      return li.price()
    },
    fAddedAt: function() { return moment(this.added_at).format(MomentFormats.Time) },
    fUnitPrice: function() { return amountFormat(this.item.unit_price) },
    fPrice: function() { return amountFormat(this.line_item.price) }    
  },
  methods: {
    bindUIDecorators: function() {
      var $this = this;
      $(this.$el).find('input[name=item_search]').autocomplete({
        source: AppRoutes.itemsAutocomplete,
        minLength: 2,
        select: function(event, ui) {
          event.preventDefault();
          event.target.value = ui.item.value.name;
          $this.item = ui.item.value
          $this.item_id = ui.item.value.id
        }
      });    
      $(this.$el).find('input[name=added_at]').datepicker({
        onSelect: (dateText) => {
          $this.added_at = dateText
        },
        dateFormat: 'yy-mm-dd'
      });
    },
    unbindUIDecorators: function() {
      $(this.$el).find('input[name=item_search]').autocomplete('destroy')
      $(this.$el).find('input[name=added_at]').datepicker('destroy')
    },
    handleUpdate: function() {
      $.ajax({
        url: AppRoutes.lineItem(this.line_item.purchase_order_id, this.line_item.id),
        method: 'PUT',
        dataType: 'json',
        data: {
          line_item: {
            added_at: this.added_at,            
            item_id: this.item_id,
            quantity: this.quantity
          }
        },
        success: (data) => {
          this.editMode = false,
          this.added_at = data.added_at,
          this.quantity = data.quantity,
          this.item = data.item,
          this.item_id = data.item_id,
          this.unit_price = data.unit_price
          this.$emit('li-updated', {line_item: this.line_item, data: data})
        }
      })
    },
    handleCancel: function() {
      this.editMode = false
    },
    handleEdit: function() {
      this.editMode = true
    },
    handleDelete: function() {
      $.ajax({
        url: AppRoutes.lineItem(this.line_item.purchase_order_id, this.line_item.id),
        method: 'DELETE',
        dataType: 'JSON',
        success: (data) => {
          this.$emit('li-deleted', {line_item: this.line_item, purchase_order: data})
        }
      })
    }    
  },
  updated: function () {
    if(this.editMode && !this.bound) {
      this.bindUIDecorators()
      this.bound = true
    } else if(!this.editMode && this.bound) {
      this.unbindUIDecorators()
      this.bound = false
    }
  },
}
</script>
