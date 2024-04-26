class OpenaiAppetizerGenerator
  # 仮想のOpenAIクライアントライブラリの例外クラスを定義
  class OpenAIError < StandardError; end

  def initialize(appetizer, api_key)
    @appetizer = appetizer
    @api_key = api_key
  end

  def call
    @client = OpenAI::Client.new(access_token: @api_key)
    begin
      build_body(@appetizer)
      response = @client.chat(
        parameters: {
          model: "gpt-4-turbo",
          messages: [{ role: "user", content: @query }]
        }
      )
      # レスポンスが問題なく返ってきているかをチェック
      if response.key?('choices') && response['choices'].any?
        response.dig('choices', 0, 'message', 'content')
      else
        raise OpenAIError, "予期せぬレスポンス形式です。"
      end
    rescue Faraday::ClientError => e
      handle_faraday_error(e)
    rescue Faraday::ServerError => e
      handle_faraday_error(e)
    rescue Faraday::Error => e
      raise OpenAIError, "通信エラーが発生しました: #{e.message}"
    end
  end

  def handle_faraday_error(e)
    status = e.response[:status]
    case status
    when 400
      raise OpenAIError, "リクエストが不正です。入力内容を確認してください。"
    when 401
      raise OpenAIError, "認証に失敗しました。管理者にお問い合わせ下さい。"
    when 403..404
      raise OpenAIError, "リクエスト先のページが存在しません。URLを確認して下さい。"
    when 408
      raise OpenAIError, "リクエストがタイムアウトしました。しばらくしてから再試行してください。"
    when 500..599
      raise OpenAIError, "サーバー側の問題が発生しました。しばらくしてから再試行してください。"
    else
      raise OpenAIError, "予期せぬエラーが発生しました。ステータスコード: #{status}"
    end
  end

  private

  def build_body(input)
    alcohol = Alcohol.find(input.alcohol_id)
    base_ingredient = Ingredient.find(input.base_ingredient_id)
    sub_ingredient = Ingredient.find(input.sub_ingredient_id)
    accent_ingredient = Ingredient.find(input.accent_ingredient_id)
    # APIに渡す回答内容、条件を指定
    @query = "#{alcohol.name}に合うおつまみの名前と解説を、以下の食材を使って1つ提案してください。

    # 食材
    #{base_ingredient.name}
    #{sub_ingredient.name}
    #{accent_ingredient.name}

    # 出力フォーマット
    おつまみ:おつまみの名前
    解説:おつまみの解説

    # 条件
    300トークン以内で出力"
  end
end