window.initMap = function() {
  // 地図の位置情報(緯度・経度)を取得
  let mapElement = document.getElementById('map');
  if (mapElement) {
    let lat = parseFloat(mapElement.getAttribute('data-latitude')) || 0;
    let lng = parseFloat(mapElement.getAttribute('data-longitude')) || 0;
    let address = mapElement.getAttribute('data-address') || '';
    let mapPosition = {lat: lat, lng: lng};
    let map = new google.maps.Map(mapElement, {
      zoom: 17,
      center: mapPosition
    });
    let contentString = '【住所】' + address;
    let infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    let marker = new google.maps.Marker({
      position: mapPosition,
      map: map,
      title: contentString
    });

    marker.addListener('click', function(){
      infowindow.open(map, marker);
    });
  }
}