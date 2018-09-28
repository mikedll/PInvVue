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
export default {
    props: ['pos']
}
</script>
