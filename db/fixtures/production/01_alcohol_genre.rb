alcohol_genres = ['ビール', '焼酎', '日本酒', 'ウイスキー', 'ブランデー', 'ワイン', 'ジン', 'ウォッカ', 'ラム', 'テキーラ', '梅酒', 'リキュール', 'サワー', '酎ハイ', 'カクテル', 'その他']
alcohol_genres.each do |genre|
  AlcoholGenre.find_or_create_by!(genre: genre)
end