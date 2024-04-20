require 'csv'

csv_file_path = 'alcohols.csv'

CSV.foreach(csv_file_path, headers: true) do |row|
  genre_name = row['genre']

  genre = AlcoholGenre.find_or_create_by!(genre: genre_name)

  Alcohol.seed(:name) do |s|
    s.name = row['name']
    s.alcohol_genre_id = genre.id
  end
end