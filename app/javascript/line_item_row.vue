<template>
<tr>
  <template v-if="!editMode">
    <td>{{ line_item.added_at }}</td>
    <td>{{ line_item.item.name }}</td>
    <td>{{ line_item.unit_price }}</td>
    <td>{{ line_item.quantity }}</td>
    <td>{{ line_item.price }} </td>
    <td>
      <button v-on:click="handleEdit">Edit</button>      
      <button v-on:click="handleDelete">Delete</button>
    </td>
  </template>
  <template v-else>
    <td><input type="text" v-model="added_at"/></td>
    <td><input type="text" name="item_search"/></td>
    <td>{{ unit_price }}</td>
    <td><input type="text" v-model="quantity"/></td>
    <td>{{ price }}</td>
    <td>
      <button v-on:click="handleUpdate">Update</button>      
      <button v-on:click="handleCancel">Cancel</button>
    </td>
  </template>
</tr>
</template>

<script>
import { AppRoutes } from 'support/appRoutes.js'

export default {
  props: ['line_item'],
  data: function() {
    return {
      editMode: false,
      added_at: this.line_item.added_at,
      quantity: this.line_item.quantity,
      item: this.line_item.item,
      item_id: this.line_item.item_id,
      unit_price: this.line_item.unit_price
    }
  },
  computed: {
    price: function() {
      return this.unit_price * this.quantity
    }
  },
  methods: {
    handleUpdate: function() {
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
  }
}
</script>
