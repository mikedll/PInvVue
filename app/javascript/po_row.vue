<template>
  <tr>
    <td>
      <a :href="poLink(po)">{{po.title}}</a>
    </td>
    <td>{{po.total}}</td>
  </tr>
</template>

<script>
export default {
  props: ['po'],
  methods: {
    poLink: function(po) {
      return '/purchase_orders/' + po.id
    }
  }
}
</script>
