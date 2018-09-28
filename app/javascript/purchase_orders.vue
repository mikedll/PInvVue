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
    <strong>Page</strong>: {{ query_result.info.page }}
    of
    {{ Math.ceil(query_result.info.total / query_result.info.per_page) }}
    <a :href="nextPage()">Next ></a>
  </div>
</template>


<script>
import poRow from 'po_row.vue'

export default {
    props: ['query_result'],
    components: {
        poRow
    },
    methods: {
        nextPage: function() {
            return "?page=" + (this.query_result.info.page + 1)
        }
    }
}
</script>
