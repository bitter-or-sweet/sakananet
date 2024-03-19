module ApplicationHelper
  def flash_color_type(type)
    case type.to_sym
    when :notice then "bg-green-100 border-green-500 text-green-700"
    when :alert then "bg-red-100 border-red-500 text-red-700"
    else "bg-gray-100 border-gray-500 text-gray-700"
    end
  end

  def show_meta_tags
    {
      site: '酒菜ネット',
      title: 'お酒&おつまみの組み合わせを共有するサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'ユーザーの投稿内容から様々なお酒、おつまみに出会うことができます。 毎日の食卓、飲み会を、より美味しく、楽しくしましょう。',
      keywords: 'お酒, おつまみ, 晩酌, 飲み会',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('ogp.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
