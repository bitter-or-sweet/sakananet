alcohol_genres = ['ビール', '焼酎', '日本酒', 'ウイスキー', 'ブランデー', 'ワイン', 'ジン', 'ウォッカ', 'ラム', 'テキーラ', '梅酒', 'リキュール', 'サワー', '酎ハイ', 'カクテル', 'その他']
alcohol_genres.each do |genre|
  AlcoholGenre.find_or_create_by!(genre: genre)
end

appetizer_genres = ['和食', '洋食', '中華', '韓国', 'イタリアン', 'フレンチ', 'スペイン', 'インド', 'タイ', 'メキシカン', 'その他']
appetizer_genres.each do |genre|
  AppetizerGenre.find_or_create_by!(genre: genre)
end

alcohols = [
  { name: 'ビール', genre: 'ビール' },
  { name: '焼酎(麦)', genre: '焼酎' },
  { name: '焼酎(芋)', genre: '焼酎' },
  { name: '焼酎(栗)', genre: '焼酎' },
  { name: '焼酎(米)', genre: '焼酎' },
  { name: '日本酒', genre: '日本酒' },
  { name: 'ハイボール', genre: 'ウイスキー' },
  { name: '赤ワイン', genre: 'ワイン' },
  { name: '白ワイン', genre: 'ワイン' },
  { name: 'ウイスキー', genre: 'ウイスキー' },
  { name: 'ブランデー', genre: 'ブランデー' }
]

alcohols.each do |alcohol|
  genre = AlcoholGenre.find_by(genre: alcohol[:genre])
  Alcohol.find_or_create_by!(name: alcohol[:name], alcohol_genre_id: genre.id)
end

ingredients = [
  { name: '牛肉', category: 'base' },
  { name: '豚肉', category: 'base' },
  { name: '鶏肉', category: 'base' },
  { name: '魚', category: 'base' },
  { name: 'キャベツ', category: 'sub' },
  { name: '大根', category: 'sub' },
  { name: 'にんじん', category: 'sub' },
  { name: 'にんにく', category: 'accent' },
  { name: '胡椒', category: 'accent' },
  { name: 'チーズ', category: 'accent' },
  { name: '唐辛子', category: 'accent' }
]

ingredients.each do |ingredient|
  Ingredient.find_or_create_by!(name: ingredient[:name], category: ingredient[:category])
end