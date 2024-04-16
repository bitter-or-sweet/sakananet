class AppetizersController < ApplicationController
  before_action :set_token, only: :index
  before_action :set_ingredients_and_alcohol, only: :index

  def new; end

  def index
    @client = OpenAI::Client.new(access_token: @api_key)
    text_params
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: @query }],
      }
    )

    # APIからの回答を取得
    full_response = response.dig("choices", 0, "message", "content")

    # 回答からおつまみの名前と解説を抽出
    if full_response && match = full_response.match(/おつまみ:\s*(.+?)\s*解説:\s*(.+)/)
      appetizer_name = match[1].strip
      appetizer_description = match[2].strip
      @appetizer = current_user.appetizers.new(
        name: appetizer_name,
        description: appetizer_description,
        alcohol_id: @alcohol.id,
        base_ingredient_id: @base_ingredient.id,
        sub_ingredient_id: @sub_ingredient.id,
        accent_ingredient_id: @accent_ingredient.id
      )
      if @appetizer.save
        flash.now[:notice] = "回答結果を取得しました"
      else
        Rails.logger.debug @appetizer.errors.full_messages.to_sentence
        flash.now[:alert] = "回答結果を取得できませんでした"
        render 'new', status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "回答結果を取得できませんでした"
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def text_params
    @query = "#{@alcohol.name}に合うおつまみの名前と解説を、以下の食材を使って1つ提案してください。

    # 食材
    #{@base_ingredient.name}
    #{@sub_ingredient.name}
    #{@accent_ingredient.name}

    #出力フォーマット
    おつまみ:おつまみの名前
    解説:おつまみの解説"
  end

  def set_ingredients_and_alcohol
    @alcohol = Alcohol.find(params[:alcohol_id])
    @base_ingredient = Ingredient.find(params[:base_ingredient_id])
    @sub_ingredient = Ingredient.find(params[:sub_ingredient_id])
    @accent_ingredient = Ingredient.find(params[:accent_ingredient_id])
  end

  def set_token
    @api_key = Rails.application.credentials.dig(:openai, :api_key)
  end
end