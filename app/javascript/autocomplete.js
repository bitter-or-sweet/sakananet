function initAutocomplete() {
  var addressInput = document.getElementById('address');
  var validPlaceSelected = false; // ユーザーが候補から選択したかどうかを判定する真偽値

  var autocomplete = new google.maps.places.Autocomplete(addressInput, {
    types: ['restaurant', 'bar'],
    componentRestrictions: {country: "jp"} // 日本国内の住所のみ検索
  });

  // 住所選択時のイベントリスナー
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      validPlaceSelected = false; // 有効な場所が選択されていない
    } else {
      validPlaceSelected = true; // 有効な場所が選択された
    }
  });

  // フォームの送信時のイベントハンドラーを追加
  document.getElementById('new_post').addEventListener('submit', function(e) {
    if (!validPlaceSelected) {
      e.preventDefault(); // フォームの送信を阻止
      alert("リストから住所を選択してください。");
    }
  });
}