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
    appetizer_name, appetizer_description = extract_appetizer_data(response)
    return false if appetizer_name.blank? || appetizer_description.blank?
    save_appetizer_data(appetizer_name, appetizer_description)
  end

  def extract_appetizer_data(response)
    # AIの回答からおつまみの名前と解説を抽出
    match = response.match(/おつまみ:\s*(.+?)\s*解説:\s*(.+)/)
    return [] unless match
    [match[1].strip, match[2].strip]
  end

  def save_appetizer_data(name, description)
    ActiveRecord::Base.transaction do
      @appetizer.update!(name: name, description: description)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Failed to save appetizer: #{e.message}")
      return false
    end
    true
  end
end