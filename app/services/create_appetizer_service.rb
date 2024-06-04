class CreateAppetizerService
  def initialize(appetizer, api_key)
    @appetizer = appetizer
    @api_key = api_key
  end

  def call
    service = OpenaiAppetizerGenerator.new(@appetizer, @api_key)
    response = service.call
    process_response(response)
  end

  private

  def process_response(response)
    return false unless response
    appetizer_name, appetizer_description, appetizer_ingredients, appetizer_steps = extract_appetizer_data(response)
    return false if appetizer_name.blank? || appetizer_description.blank? || appetizer_ingredients.blank? || appetizer_steps.blank?
    save_appetizer_data(appetizer_name, appetizer_description, appetizer_ingredients, appetizer_steps)
  end

  def extract_appetizer_data(response)
    # AIの回答からおつまみの名前、解説、材料、分量、手順を抽出
    match = response.match(/おつまみ:\s*(.+?)\n解説:\s*(.+?)\n材料:(.+?)手順:\s*([\s\S]+)/m)
    return [] unless match
    name = match[1].strip
    description = match[2].strip
    ingredients_text = match[3].strip
    steps = match[4].strip

    # 材料リストの抽出
    ingredients = ingredients_text.scan(/材料\d+:\s*([^:]+)-([^:\n]+)/).map do |ingredient_name, quantity|
      { name: ingredient_name.strip, amount: quantity.strip }
    end

    [name, description, ingredients, steps]
  end

  def save_appetizer_data(name, description, ingredients, steps)
    ingredients_text = ingredients.map.with_index(1) do |ingredient, index|
      "材料#{index}: #{ingredient[:name]} - #{ingredient[:amount]}"
    end.join("\n")

    responce_text = "#{description}\n材料:\n#{ingredients_text}\n手順:\n#{steps}"
    full_description = responce_text.gsub(/(?<!^)(ステップ\d+:)/, "\n\\1")

    ActiveRecord::Base.transaction do
      if @appetizer.update(name: name, description: full_description)
          true
      else
          Rails.logger.error("Update failed")
          false
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Failed to save appetizer: #{e.message}")
      false
    end
  end
end