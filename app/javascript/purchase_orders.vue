<template>
  <div class="results-container">
    <table>
      <thead>
        <tr>
          <th>Title</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        <po-row v-for="i in query_result.results" v-bind:po="i" v-bind:key="i.id"></po-row>
      </tbody>
    </table>
    <paginator v-bind:query_info="query_result.info"></paginator>
  </div>
</template>


<script>
import poRow from 'po_row.vue'
import paginator from 'paginator.vue'

export default {
    props: ['query_result'],
    components: {
        poRow, paginator
    }
}
</script>
