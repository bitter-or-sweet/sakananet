class AppetizersController < ApplicationController
  before_action :set_token, only: :create
  before_action :set_genres, only: %i[new create]

  def index
    @appetizers = Appetizer.where(user_id: params[:user_id]).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @appetizer = Appetizer.new
    @selected_genres = AlcoholGenre.where(genre: ["ビール", "焼酎", "日本酒", "ウイスキー", "ブランデー", "ワイン", "梅酒", "サワー", "酎ハイ"])
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
    rescue StandardError
      flash.now[:alert] = "予期せぬエラーが発生しました。もう一度お試しいただくか、管理者までお問い合わせください。"
      @selected_genres = AlcoholGenre.where(genre: ["ビール", "焼酎", "日本酒", "ウイスキー", "ブランデー", "ワイン", "梅酒", "サワー", "酎ハイ"])
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @appetizer = Appetizer.find(params[:id])
  end

  private

  def appetizer_params
    params.require(:appetizer).permit(:alcohol_id, :base_ingredient_id, :sub_ingredient_id, :accent_ingredient_id)
  end

  def set_token
    @api_key = Rails.application.credentials.dig(:openai, :api_key)
  end

  def set_genres
    @selected_genres = AlcoholGenre.where(genre: ["ビール", "焼酎", "日本酒", "ウイスキー", "ブランデー", "ワイン", "梅酒", "サワー", "酎ハイ"])
  end
end