<template>
  <div className="container">
    <nav>
      <ul className="pagination">
        <li v-for="la in linkAttrs" :key="'page-' + la[0]" v-if="la">
          <a :href="la[4] ? '#' : la[2]">{{ la[1] }}</a>
        </li>
      </ul>
    </nav>
  </div>  
</template>

<script>
import { serializeObj, getUrlQueryAsObj } from 'support/urlHelper'
import _ from 'underscore'

function makeLinkHref(component, page) {
  const obj = Object.assign({}, component.getQuery, component.query_info.query, {page: page});
  if (obj.page === 1) delete obj.page
  return '?' + serializeObj(obj)
}

export default {
  props: ['query_info'],
  data: function() {
    return {
      getQuery: getUrlQueryAsObj()
    }
  },
  computed: {
    linkAttrs: function() {
      const pages = Math.ceil(this.query_info.total / this.query_info.per_page);

      const prev = (this.query_info.page > 1) ? ['prev', '‹ Prev', makeLinkHref(this, this.query_info.page-1), false, false] : null;
      const next = (this.query_info.page < pages) ? ['next', 'Next ›', makeLinkHref(this, this.query_info.page+1), false, false] : null;
      const first = (pages > 1 && this.query_info.page > 1) ? ['first', '« First', makeLinkHref(this, 1), false, false] : null;
      const last = (pages > 1 && this.query_info.page < pages) ? ['last', 'Last »', makeLinkHref(this, pages), false, false] : null;

      // This could be improved to act more like Kaminari's pagination.
      // For example, Kariminar does not display more than four pages to the right
      // on page 1 even if there are more than five pages.
      const paddedLinks = Math.floor(9 / 2);
      const extraOnRight = Math.max(0, 1 - (this.query_info.page - paddedLinks));
      const extraOnLeft = Math.max(0, paddedLinks - (pages - this.query_info.page));
      const middleMin = Math.max(1, this.query_info.page - paddedLinks - extraOnLeft);
      const middleMax = Math.min(pages, this.query_info.page + paddedLinks + extraOnRight);

      const middle = _.times(pages, (i) => i+1).filter((page) => {
        return page >= middleMin && page <= middleMax;
      }).map((page) => {
        return [page, page, makeLinkHref(this, page), page == this.query_info.page, false];
      });
      if(middleMin > 1) middle.unshift(['min-padding', '…', makeLinkHref(this, 1), false, true]);    
      if(middleMax < pages) middle.push(['max-padding', '…', makeLinkHref(this, 1), false, true]);

      return [first, prev, ...middle, next, last];
    }
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
