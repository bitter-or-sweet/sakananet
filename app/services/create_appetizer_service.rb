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
    # AIの回答からおつまみの名前と解説を抽出
    response && match = response.match(/おつまみ:\s*(.+?)\s*解説:\s*(.+)/)
    appetizer_name = match[1].strip
    appetizer_description = match[2].strip
    # 抽出したデータがすべて存在するかチェック
    if appetizer_name.blank? || appetizer_description.blank?
      return false # 抽出したデータがすべて存在しなければ失敗を返す
    else
      ActiveRecord::Base.transaction do
        # 抽出したデータを@appetizerに保存
        @appetizer.name = appetizer_name
        @appetizer.description = appetizer_description
        @appetizer.save! #save! を使用して明示的に例外を発生
      end
      true # 保存が成功した場合、trueを返す
    end
  end
end