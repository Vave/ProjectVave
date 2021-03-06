<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  <title>Bing Map</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>
  <script type="text/javascript">
  <%
  String adresse = request.getParameter("adr");
  %>
  
  var map = null;
  var searchManager = null;
  function getMap()
  {
    map = new Microsoft.Maps.Map(document.getElementById('myMap'), {credentials:"At2yMksHgbVTkvDD3lnZPz6qGwAc6GN4eM51sd3TIH0PsdG7752GTMOWQEHke8SS"});
    LoadSearchModule()
  }
   function createSearchManager() 
  {
     map.addComponent('searchManager', new Microsoft.Maps.Search.SearchManager(map)); 
     searchManager = map.getComponent('searchManager'); 
  }
  function LoadSearchModule()
  {
    Microsoft.Maps.loadModule('Microsoft.Maps.Search', { callback: geocodeRequest })
  }
  function geocodeRequest() 
  { 
    createSearchManager();
    var where = '<%=adresse%>'; 
    var userData = { name: 'Maps Test User', id: 'XYZ' }; 
    var request = 
    { 
        where: where, 
        count: 5, 
        bounds: map.getBounds(), 
        callback: onGeocodeSuccess, 
        errorCallback: onGeocodeFailed, 
        userData: userData 
    }; 
    searchManager.geocode(request); 
  } 
  function extractUrlParams(){	
		var t = location.search.substring(1).split('&');
		var f = [];
		for (var i=0; i<t.length; i++){
			var x = t[ i ].split('=');
			f[x[0]]=x[1];
		}
		return f;
	}
  function onGeocodeSuccess(result, userData) 
  { 
    if (result) { 
        map.entities.clear(); 
        var topResult = result.results && result.results[0]; 
        if (topResult) { 
            var pushpin = new Microsoft.Maps.Pushpin(topResult.location, null); 
            map.setView({ center: topResult.location, zoom: 12 }); 
            map.entities.push(pushpin); 
        } 
    } 
  } 
  function onGeocodeFailed(result, userData) { 
    alert('Geocode failed'); 
  } 
  </script>
  </head>
  <body onload="getMap();">
    <div id='myMap' style="position:relative; width:400px; height:400px;"></div>
  
  </body>
</html>
