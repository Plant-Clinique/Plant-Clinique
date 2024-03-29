  mapboxgl.accessToken = 'pk.eyJ1Ijoib3NhbWFoNyIsImEiOiJja25rcnMzNHUwYnlsMnBuMXoxNTRtaXF1In0.eTGxtcx1aQ-6fiv4pdDqQw'; // set the access token
  
  let map = new mapboxgl.Map({
    container: 'map', // The container ID
    style: 'mapbox://styles/osamah7/cknmfhbhy0zfv17qzounel1b6', // The map style to use
    center: [-71.25905434334308, 42.36490609061847], // Starting position [lng, lat]
    zoom: 9 // Starting zoom level
  });

  let geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
    trackUserLocation: true
  });

  map.addControl(geolocate);

  map.on('load', function() {
    
    let geocoder = new MapboxGeocoder({ // Initialize the geocoder
      accessToken: mapboxgl.accessToken, // Set the access token
      mapboxgl: mapboxgl, // Set the mapbox-gl instance
      zoom: 12, // Set the zoom level for geocoding results
      placeholder: "Search for plant stores", // This placeholder text will display in the search bar
      bbox: [ -73.69750177040083, 41.796247795148815, -69.71313359288317, 42.84056170969422] // Set a bounding box
    });
    // Add the geocoder to the map
    map.addControl(geocoder, 'top-left'); // Add the search box to the top left

    let marker = new mapboxgl.Marker({'color': '#008000'}) // Create a new green marker

    geocoder.on('result', function(data) { // When the geocoder returns a result
      let point = data.result.center; // Capture the result coordinates
      marker.setLngLat(point).addTo(map); // Add the marker to the map at the result coordinates
      let tileset = 'osamah7.7euhsy8k'; // replace this with the ID of the tileset you created
      let radius = 3000; // 1609 meters is roughly equal to one mile
      let limit = 50; // The maximum amount of results to return
      let query = 'https://api.mapbox.com/v4/' + tileset + '/tilequery/' + point[0] + ',' + point[1] + '.json?radius=' + radius + '&limit= ' + limit + ' &access_token=' + mapboxgl.accessToken;
    
      $.ajax({ // Make the API call
        method: 'GET',
        url: query,
      }).done(function(data) { // Use the response to populate the 'tilequery' source
        map.getSource('tilequery').setData(data);
      })
    });

    geolocate.on('geolocate', function(position) {
      let point = [position.coords.longitude, position.coords.latitude]; // Capture the result coordinates
      marker.setLngLat(point).addTo(map); // Add the marker to the map at the result coordinates
      let tileset = 'osamah7.7euhsy8k'; // replace this with the ID of the tileset you created
      let radius = 3000; // 1609 meters is roughly equal to one mile
      let limit = 50; // The maximum amount of results to return
      let query = 'https://api.mapbox.com/v4/' + tileset + '/tilequery/' + point[0] + ',' + point[1] + '.json?radius=' + radius + '&limit= ' + limit + ' &access_token=' + mapboxgl.accessToken;
    
      $.ajax({ // Make the API call
        method: 'GET',
        url: query,
      }).done(function(data) { // Use the response to populate the 'tilequery' source
        map.getSource('tilequery').setData(data);
      })
    });

    map.addSource('tilequery', { // Add a new source to the map style: https://docs.mapbox.com/mapbox-gl-js/api/#map#addsource
      type: "geojson",
      data: {
        "type": "FeatureCollection",
        "features": []
      }
    });

    map.addLayer({ // Add a new layer to the map style: https://docs.mapbox.com/mapbox-gl-js/api/#map#addlayer
      id: "tilequery-points",
      type: "circle",
      source: "tilequery", // Set the layer source
      paint: {
        "circle-stroke-color": "white",
        "circle-stroke-width": { // Set the stroke width of each circle: https://docs.mapbox.com/mapbox-gl-js/style-spec/#paint-circle-circle-stroke-width
          stops: [
            [0, 10],
            [18, 3]
          ],
          base: 5
        },
        "circle-radius": { // Set the radius of each circle, as well as its size at each zoom level: https://docs.mapbox.com/mapbox-gl-js/style-spec/#paint-circle-circle-radius
          stops: [
            [15, 10],
            [22, 180]
          ],
          base: 5
        },
        "circle-color": [ // Specify the color each circle should be
          'match', // Use the 'match' expression: https://docs.mapbox.com/mapbox-gl-js/style-spec/#expressions-match
          ['get', 'STORE_TYPE'], // Use the result 'STORE_TYPE' property
          'Florist', '#FF69B4',
          '#008000' // any other store type
        ]
      }
    });
    let popup = new mapboxgl.Popup; // Initialize a new popup

    map.on('mouseenter', 'tilequery-points', function(e) {
      map.getCanvas().style.cursor = 'pointer';
    })

    map.on('click', 'tilequery-points', function(e) {
      map.getCanvas().style.cursor = ''; // When the cursor enters a feature, set it to a pointer

      let title = '<h5>' + e.features[0].properties.STORE_NAME + '</h5>'; // Set the store name
      let storeType = '<h6> Store type: ' + e.features[0].properties.STORE_TYPE + '</h6>'; // Set the store type

      let lon = e.features[0].properties.longitude;
      let lat = e.features[0].properties.latitude;

      let obj = JSON.parse(e.features[0].properties.tilequery); // Get the feature's tilequery object (https://docs.mapbox.com/api/maps/#response-retrieve-features-from-vector-tiles)
      let distance = '<p>' + (obj.distance / 1609.344).toFixed(2) + ' mi. from location' + '</p>'; // Take the distance property, convert it to miles, and truncate it at 2 decimal places
      
      let coordinates = new mapboxgl.LngLat(lon, lat); // Create a new LngLat object (https://docs.mapbox.com/mapbox-gl-js/api/#lnglatlike)
      let content = title + storeType + distance; // All the HTML elements

      popup.setLngLat(coordinates) // Set the popup at the given coordinates
        .setHTML(content) // Set the popup contents equal to the HTML elements you created
        .addTo(map); // Add the popup to the map
    })

    map.on('mouseleave', 'tilequery-points', function() {
      map.getCanvas().style.cursor = ''; // Reset the cursor when it leaves the point
    });
  });  
