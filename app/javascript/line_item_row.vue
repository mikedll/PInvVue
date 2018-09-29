<template>
  <tr >
    <td>{{ line_item.item.name }}</td>
    <td></td>
    <td>{{ line_item.price }} </td>
    <td>
      Edit
      <button v-on:click="handleDelete">Delete</button>
    </td>
  </tr>
</template>

<script>
  
export default {
  props: ['line_item'],
  data: function() {
    return {}
  },
  methods: {
    handleDelete: function() {
      $.ajax({
        url: '/purchase_orders/' + this.line_item.purchase_order_id + '/line_items/' + this.line_item.id,
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
