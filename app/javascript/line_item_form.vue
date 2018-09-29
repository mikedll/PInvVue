<template>
  <form className="form-inline" v-on:submit.prevent="handleSubmit">
    <div className="form-group mb-2 mr-sm-2">
      <input type="text" className="form-control" placeholder="Date" value={this.state.added_at} name="added_at" onChange={this.handleChange}/>
    </div>
    <div className="form-group mb-2 mr-sm-2">
      <input type="text" className="form-control" placeholder="Item" name="item_search"/>
    </div>
    <div className="form-group mb-2 mr-sm-2">
      <input type="text" className="form-control" placeholder="Quantity" value={this.state.quantity} name="quantity" onChange={this.handleChange}/>
    </div>
    <div className="form-group mb-2 mr-sm-2">
      <strong>{this.price()}</strong>
    </div>
    <button type="submit" className="btn btn-primary mb-2" disabled={!this.valid()}>Create line item</button>
  </form>
</template>

<script>
export default {
  methods: {
    handleSubmit: function() {
      this.$emit('newLineItem', {})
    }
  }
}
</script>
