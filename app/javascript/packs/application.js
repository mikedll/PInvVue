console.log('Hello World from Webpacker');

// import vue from 'vue';

import build from '../components/purchase_orders.js';

window.invoke_render = function() {

  var tableNode = $('<table></table>');

  var theadNode = $("<thead><tr><th>Title</th><th>Total</th></tr></thead>"); 
  var tbodyNode = $('<tbody></tbody');

  for(var i = 0; i< __bootstrap.length; i++) {
    tbodyNode.append(build(__bootstrap[i]));
  }

  tableNode.append(theadNode);
  tableNode.append(tbodyNode);
  
  $('.main-container').append(tableNode);

};



