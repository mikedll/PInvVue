<template>
  <div class="purchase-order">
    A PO!
    
    {{ record.title }}

    <line-items :purchase_order_id="record.id" :line_items="record.line_items" :total="record.total"></line-items>
  </div>  
</template>

<script>
import lineItems from 'line_items.vue'

export default {
  components: {
    lineItems
  },
  props: ['record']
}
</script>
