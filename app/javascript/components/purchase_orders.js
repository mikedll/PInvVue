
function build(po) {
  var trNode = $('<tr><td>' + po.title + '</td><td>' + po.total + '</td></tr>');
  return trNode;
}

export default build;

