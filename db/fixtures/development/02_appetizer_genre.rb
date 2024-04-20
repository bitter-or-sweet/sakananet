appetizer_genres = ['和食', '洋食', '中華', '韓国', 'イタリアン', 'フレンチ', 'スペイン', 'インド', 'タイ', 'メキシカン', 'その他']
appetizer_genres.each do |genre|
  AppetizerGenre.find_or_create_by!(genre: genre)
end