// https://stackoverflow.com/questions/1714786/query-string-encoding-of-a-javascript-object
var serializeObj = function serializeObj(obj) {
  var str = [];
  for (var p in obj)
    if (obj.hasOwnProperty(p)) {
      str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
    }
  return str.join("&");  
};

// https://stackoverflow.com/questions/8648892/convert-url-parameters-to-a-javascript-object
var getUrlQueryAsObj = function getUrlQueryAsObj() {
  if(typeof(window) === "undefined") return null;
  
  var search = window.location.search.substring(1).replace(/^\s+|\s+$/g, '');

  if(search === '') return {};

  return search.split("&").reduce(function(prev, curr, i, arr) {
    var p = curr.split("=");
    prev[decodeURIComponent(p[0])] = p[1] === undefined ? true : decodeURIComponent(p[1]);
    return prev;
  }, {});
};

export { serializeObj, getUrlQueryAsObj };
