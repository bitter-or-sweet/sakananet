alcohol_genres = ['ビール', '焼酎', '日本酒', 'ウイスキー', 'ブランデー', 'ワイン', 'ジン', 'ウォッカ', 'ラム', 'テキーラ', '梅酒', 'リキュール', 'サワー', '酎ハイ', 'カクテル', 'その他']
alcohol_genres.each do |genre|
  AlcoholGenre.find_or_create_by!(genre: genre)
end

appetizer_genres = ['和食', '洋食', '中華', '韓国', 'イタリアン', 'フレンチ', 'スペイン', 'インド', 'タイ', 'メキシカン', 'その他']
appetizer_genres.each do |genre|
  AppetizerGenre.find_or_create_by!(genre: genre)
end