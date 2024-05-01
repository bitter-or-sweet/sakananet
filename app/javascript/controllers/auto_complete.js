window.initAutocomplete = function () {
  var addressInput = document.getElementById('address');
  var validPlaceSelected = false; // ユーザーが候補から選択したかどうかを判定する真偽値

  var autocomplete = new google.maps.places.Autocomplete(addressInput, {
    types: ['restaurant', 'bar'],
    componentRestrictions: {country: "jp"} // 日本国内の住所のみ検索
  });

  // 住所選択時のイベントリスナー
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    validPlaceSelected = !!place.geometry;  // 有効な場所が選択されたかを更新
  });
}