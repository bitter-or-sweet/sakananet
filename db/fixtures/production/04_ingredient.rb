require 'csv'

csv_file_path = 'ingredients.csv'

CSV.foreach(csv_file_path, headers: true) do |row|
  Ingredient.seed(:name) do |s|
    s.category = row['category']
    s.name = row['name']
  end
end