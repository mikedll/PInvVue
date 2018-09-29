<template>
  <form class="form-inline" v-on:submit.prevent="handleSubmit">
    <div class="form-group mb-2 mr-sm-2">
      <input type="text" class="form-control" placeholder="Date" v-model="added_at" name="added_at"/>
    </div>
    <div class="form-group mb-2 mr-sm-2">
      <input type="text" class="form-control" placeholder="Item" name="item_search"/>
    </div>
    <div class="form-group mb-2 mr-sm-2">
      <input type="text" class="form-control" placeholder="Quantity" v-model="quantity"/>
    </div>
    <div class="form-group mb-2 mr-sm-2">
      <strong>{{ price }}</strong>
    </div>
    <button type="submit" class="btn btn-primary mb-2" :disabled="!valid">Create line item</button>
  </form>
</template>

<script>
import { AppRoutes } from 'support/appRoutes.js'
  
export default {
  props: ['purchase_order_id'],
  data: function() {
    return {
      added_at: '2018-09-27',
      quantity: '2',
      item: null,
      item_id: ''
    }
  },
  mounted: function() {
    const $this = this
    $(this.$el).find('input[name=item_search]').autocomplete({
      source: AppRoutes.itemsAutocomplete,
      minLength: 2,
      select: function(event, ui) {
        event.preventDefault()
        event.target.value = ui.item.value.name
        $this.item = ui.item.value
        $this.item_id = ui.item.value.id
      }
    })

    $(this.$el).find("input[name=added_at]").datepicker({
      onSelect: (dateText) => {
        this.added_at = dateText
      },
      dateFormat: 'yy-mm-dd'
    });
  },  
  beforeDestroy: function() {
    $(this.$el).find('input[name=item_search]').autocomplete('destroy');
    $(this.$el).find('input[name=added_at]').datepicker('destroy');
  },  
  computed: {
    valid: function() {
      return (this.item_id && this.added_at && this.quantity && !isNaN(parseFloat(this.quantity)))
    },
    price: function() {
      const qtyF = parseFloat(this.quantity)
      if (isNaN(qtyF) || this.item === null) return null
      return (qtyF * this.item.unit_price)
    }
  },
  methods: {
    handleSubmit: function() {
      $.ajax({
        method: 'POST',
        url: AppRoutes.lineItems(this.purchase_order_id),
        dataType: 'JSON',
        data: {
          line_item: {
            quantity: this.quantity,
            added_at: this.added_at,
            item_id: this.item_id
          }
        },
        success: (data) => {
          $(this.$el).find('input[name=item_search]').val('')
          this.added_at = ''
          this.quantity = ''
          this.item = null
          this.item_id = ''
          this.$emit('li-added', data)
        }
      })
      
    }
  }
}
</script>
