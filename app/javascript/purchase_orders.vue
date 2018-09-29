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

    <a :href="nextPageHref()" v-if="hasNextLink()">Next ></a>
  </div>
</template>


<script>
import poRow from 'po_row.vue'
import { serializeObj, getUrlQueryAsObj } from 'support/urlHelper'

function nextLink(component) {
    const maxPages = Math.ceil(component.query_result.info.total / component.query_result.info.per_page)
    const nextPage = (component.query_result.info.page + 1)
    if(nextPage > maxPages) return null;
    
    const query = getUrlQueryAsObj();
    query.page = nextPage;

    return serializeObj(query);
}

export default {
    props: ['query_result'],
    components: {
        poRow
    },
    methods: {
        hasNextLink: function() {
            return nextLink(this) !== null
        },
        nextPageHref: function() {
            return "?" + nextLink(this);
        }
    }
}
</script>
