class AppetizersController < ApplicationController
  ALCOHOL_GENRES = ["ビール", "焼酎", "日本酒", "ウイスキー", "ブランデー", "ワイン", "梅酒", "サワー", "酎ハイ"]

  before_action :set_token, only: :create
  before_action :set_genres, only: %i[new create]
  before_action :set_description_steps, only: :show

  def index
    @appetizers = Appetizer.where(user_id: params[:user_id]).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @appetizer = Appetizer.new
  end

  def create
    @appetizer = current_user.appetizers.build(appetizer_params)
    begin
      service = CreateAppetizerService.new(@appetizer, @api_key)
      if service.call
        redirect_to appetizer_path(@appetizer), notice: "回答結果を取得しました"
      else
        flash.now[:alert] = "回答結果を取得できませんでした"
        render 'new', status: :unprocessable_entity
      end
    rescue OpenaiAppetizerGenerator::OpenAIError => e
      flash.now[:alert] = e.message
      render :new, status: :unprocessable_entity
    rescue StandardError => e
      Rails.logger.error("Standard Error: #{e.message}")
      flash.now[:alert] = "予期せぬエラーが発生しました。もう一度お試しいただくか、管理者までお問い合わせください。"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def appetizer_params
    params.require(:appetizer).permit(:alcohol_id, :base_ingredient_id, :sub_ingredient_id, :accent_ingredient_id)
  end

  def set_token
    @api_key = Rails.application.credentials.dig(:openai, :api_key)
  end

  def set_genres
    @alcohol_genres = AlcoholGenre.where(genre: ALCOHOL_GENRES)
  end

  def set_description_steps
    @appetizer = Appetizer.find(params[:id])
    # 元のテキストを "材料(最大5個):" で分割
    parts = @appetizer.description.split("材料(最大5個):")
    description = parts[0].strip if parts.size > 1
    ingredients_and_steps = parts[1].strip if parts.size > 1

    # ingredients_and_stepsを "手順:" で分割
    if ingredients_and_steps
      ingredients_part, steps_part = ingredients_and_steps.split("\n手順:", 2).map(&:strip)
    else
      ingredients_part = ""
      steps_part = ""
    end

    description = description.sub('解説: ', '').strip

    # 材料名と量を抽出
    @ingredients = ingredients_part.scan(/材料\d+: ([^\n-]+) - ([^\n]+)/).map do |name, amount|
      { name: name.strip, amount: amount.strip }
    end

    steps_text = "ステップ1:" + steps_part
    steps = steps_text.scan(/ステップ\d+: ([^\n]+)/)

    @description = description
    @first_step = steps[0] ? steps[0][0] : nil
    @second_step = steps[1] ? steps[1][0] : nil
    @third_step = steps[2] ? steps[2][0] : nil
  end
end