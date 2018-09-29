<template>
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
        <tr v-for="li in line_items">
          <td>{{ li.item.name }}</td>
          <td></td>
          <td>{{ li.price }} </td>
          <td>
            Edit
            <button v-on:click="clicked">Delete</button>
          </td>
        </tr>
        <tr>
          <td colspan="2">Total:</td>
          <td><strong>{{ total }}</strong></td>
          <td></td>
        </tr>
      </tbody>
    </table>
</template>

<script>

export default {
  props: ['total', 'line_items'],
  methods: {
    clicked: function() {
      console.log("Clicked delete")
    }
  }
}
</script>
