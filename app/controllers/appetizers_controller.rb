class AppetizersController < ApplicationController
  before_action :set_token, only: :create

  def new
    @appetizer = Appetizer.new
    @selected_genres = AlcoholGenre.where(genre: ["ビール", "焼酎", "日本酒", "ウイスキー", "ブランデー", "ワイン", "梅酒", "サワー", "酎ハイ"])
  end

  def create
    @client = OpenAI::Client.new(access_token: @api_key)
    build_body(appetizer_params)
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: @query }]
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
        alcohol_id: appetizer_params[:alcohol_id],
        base_ingredient_id: appetizer_params[:base_ingredient_id],
        sub_ingredient_id: appetizer_params[:sub_ingredient_id],
        accent_ingredient_id: appetizer_params[:accent_ingredient_id]
      )
      if @appetizer.save
        redirect_to appetizer_path(@appetizer), notice: "回答結果を取得しました"
      else
        flash.now[:alert] = "回答結果を取得できませんでした"
        render 'new', status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "回答結果を取得できませんでした"
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @appetizer = Appetizer.find(params[:id])
  end

  private

  def build_body(input)
    alcohol = Alcohol.find(input[:alcohol_id])
    base_ingredient = Ingredient.find(input[:base_ingredient_id])
    sub_ingredient = Ingredient.find(input[:sub_ingredient_id])
    accent_ingredient = Ingredient.find(input[:accent_ingredient_id])

    @query = "#{alcohol.name}に合うおつまみの名前と解説を、以下の食材を使って1つ提案してください。

    # 食材
    #{base_ingredient.name}
    #{sub_ingredient.name}
    #{accent_ingredient.name}

    # 出力フォーマット
    おつまみ:おつまみの名前
    解説:おつまみの解説"
  end

  def appetizer_params
    params.require(:appetizer).permit(:alcohol_id, :base_ingredient_id, :sub_ingredient_id, :accent_ingredient_id)
  end

  def set_token
    @api_key = Rails.application.credentials.dig(:openai, :api_key)
  end
end