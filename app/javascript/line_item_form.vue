<template>
  <form className="form-inline" v-on:submit.prevent="handleSubmit">
    <div className="form-group mb-2 mr-sm-2">
      <input type="text" className="form-control" placeholder="Date" v-model="added_at" name="added_at"/>
    </div>
    <div className="form-group mb-2 mr-sm-2">
      <input type="text" className="form-control" placeholder="Item"  v-model="item_search"name="item_search"/>
    </div>
    <div className="form-group mb-2 mr-sm-2">
      <input type="text" className="form-control" placeholder="Quantity" v-model="quantity"/>
    </div>
    <div className="form-group mb-2 mr-sm-2">
      <strong>{{ price }}</strong>
    </div>
    <button type="submit" className="btn btn-primary mb-2" disabled={!this.valid}>Create line item</button>
  </form>
</template>

<script>
import { AppRoutes } from 'support/appRoutes.js'
  
export default {
  data: function() {
    return {
      item_search: '',
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

    // this.$el.find("input[name=added_at]").datepicker({
    //   onSelect: (dateText) => {
    //     this.setState({added_at: dateText});
    //   },
    //   dateFormat: 'yy-mm-dd'
    // });
  },  
  beforeDestroy: function() {
    $(this.$el).find('input[name=item_search]').autocomplete('destroy');
  },  
  computed: {
    valid: function() {
      return (this.item_id && this.added_at && this.m_quantity && !isNaN(parseFloat(this.quantity)))
    },
    price: function() {
      const qtyF = parseFloat(this.m_quantity)
      if (isNaN(qtyF) || this.item === null) return null
      return (qtyF * this.item.unit_price)
    }
  },
  watch: {
    item_search: function(newItemSearch, oldItemSearch) {
      if(newItemSearch.length > 2) {
      }
      // send out ajax search here...
    }
  },
  methods: {
    handleSubmit: function() {
      $.ajax({
        method: 'POST',
        url: '/purchase_orders/' + this.purchase_order.id + '/line_items',
        dataType: 'JSON',
        data: {
          quantity: this.quantity,
          added_at: this.added_at,
          item_id: this.item_id
        },
        success: (data) => {
          this.item_search = ''
          this.added_at = ''
          this.quantity = ''
          this.item = null
          this.item_id = ''
          this.$emit('li-added', {line_item: data})
        }
      })
      
    }
  }
}
</script>
