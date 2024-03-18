alcohol_genres = ['ビール', '焼酎', '日本酒', 'ウイスキー', 'ワイン', 'その他']
alcohol_genres.each do |genre|
  AlcoholGenre.find_or_create_by!(genre: genre)
end

appetizer_genres = ['和食', '洋食', '中華', '韓国', 'イタリアン', 'フレンチ', 'その他']
appetizer_genres.each do |genre|
  AppetizerGenre.find_or_create_by!(genre: genre)
end