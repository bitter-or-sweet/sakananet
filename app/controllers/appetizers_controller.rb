class AppetizersController < ApplicationController
  ALCOHOL_GENRES = ["ビール", "焼酎", "日本酒", "ウイスキー", "ブランデー", "ワイン", "梅酒", "サワー", "酎ハイ"]

  before_action :set_token, only: :create

  def index
    @appetizers = Appetizer.where(user_id: params[:user_id]).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @appetizer = Appetizer.new
    @alcohol_genres = AlcoholGenre.where(genre: ALCOHOL_GENRES)
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
      @alcohol_genres = AlcoholGenre.where(genre: ALCOHOL_GENRES)
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
end