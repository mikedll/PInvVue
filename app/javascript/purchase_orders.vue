<template>
<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Total</th>
    </tr>
  </thead>
  <tbody>
    <po-row v-for="i in pos" v-bind:po="i" v-bind:key="i.id"></po-row>
  </tbody>
</table>
</template>

<script>
  import poRow from 'po_row.vue';
  
export default {
    props: ['pos'],
    components: {
        poRow
        }
}
</script>
