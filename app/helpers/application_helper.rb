module ApplicationHelper
  def flash_color_type(type)
    case type.to_sym
    when :notice then "bg-green-100 border-green-500 text-green-700"
    when :alert then "bg-red-100 border-red-500 text-red-700"
    else "bg-gray-100 border-gray-500 text-gray-700"
    end
  end

  def default_meta_tags
    {
      site: '',
      title: '',
      reverse: true,
      charset: 'utf-8',
      description: 'ユーザーの投稿内容から様々なお酒、おつまみに出会うことができます。 毎日の食卓、飲み会を、より美味しく、楽しくしましょう。',
      keywords: 'お酒, おつまみ, 晩酌, 飲み会',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: '',
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        title: '酒菜ネット',
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('ogp.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end

  def page_title(page_title = '')
    base_title = '酒菜ネット'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def alcohol_details
    {
    'ビール' => { image: 'beer.webp', description: '中心にはスタイリッシュでホップのような泡立つビールグラスが配され、周囲には大麦の茎が描かれている。活気のある豪華なデザインとなっており、ビール知識の最高峰に与えられる称号。'},
    '焼酎' => { image: 'shochu.webp', description: '中心には金色の蒸留器が配置され、周囲にはサツマイモや大麦など、焼酎の原料を象徴する要素が含まれている。焼酎知識の最高位の専門性と名誉を表すために適した豪華で高級感のある称号。' },
    '日本酒' => { image: 'jp_sake.webp', description: '金色の日本酒の盃と桜の花をモチーフとし、日本酒文化の深い知識を象徴している。全体的に豊かで権威ある外観であり、日本酒知識の頂点に与えられる称号。'},
    'ウイスキー' => { image: 'whisky.webp', description: '中央に金色のウイスキーグラスがあり、周りには大麦とオークの葉の複雑な彫刻が施され、豪華で洗練されたデザインとなっている。ウイスキー知識の最高峰に与えられる称号。'},
    'ブランデー' => { image: 'brandy.webp', description: '金色のスニフターグラスが中央に配され、背景は王室のような色。周りにはブドウのツルとオークの葉の装飾が描かれ、豪華で威厳のあるデザインであり、ブランデー知識の最高峰に与えられる称号。'},
    'ワイン' => { image: 'wine.webp', description: '金色のワイングラスが中央にあり、周りはブドウの蔓とワイン樽の複雑な彫刻が施されてる。グラスからエレガントに上がるワインのしぶきが描かれており、ワインテイスティングの達人に与えられる称号。'},
    'ジン' => { image: 'gin.webp', description: '中心に金色のジンボトルが配置され、周囲にはジュニパーベリー、柑橘類の皮などの植物素材が配されている。ハーブと花の模様の繊細な彫刻が施され、ジン知識の最高峰に与えられる称号。'},
    'ウォッカ' => { image: 'vodka.webp', description: '中心に金色のウォッカボトルが配置され、周囲にはウォッカの主要成分である小麦とライ麦が描かれている。全体的にエレガントで権威あるデザインであり、ウォッカ知識の最高峰に与えられる称号。'},
    'ラム' => { image: 'rum.webp', description: '中心に金色のラムボトルが配置され、周囲にはサトウキビやトロピカルフルーツ（パイナップル、ココナッツ）が描かれている。華やかなデザインとカリブ海の象徴が施されておりラム知識の最高峰に与えられる称号。'},
    'テキーラ' => { image: 'tequila.webp', description: '中央に金色のテキーラボトルが配置され、その周囲にはテキーラ製造に不可欠なブルーアガベが描かれている。メキシコ風の装飾パターンとシンボルが施されており、テキーラ知識の最高峰に与えられる称号。'},
    '梅酒' => { image: 'plum_wine.webp', description: '中央に金色の梅の花が配置され、その周囲には梅の実と葉が描かれており、梅酒製造の主要成分を象徴している。全体的に洗練された繊細なデザインとなっており、梅酒知識の最高峰に与えられる称号。'},
    'リキュール' => { image: 'liqueur.webp', description: '中央に金色のカクテルグラスが配置され、周囲にはオレンジ、ミント、シナモンなどが配されている。エレガントな花と植物のパターンが施され、リキュール知識の最高峰に与えられる称号。'},
    'サワー' => { image: 'sour.webp', description: '活気あるライムグリーン色で、金色のグラスとの鮮やかなコントラストが特徴となっている。活動的な色で洗練されたデザインが施されており、サワーカクテル知識の最高峰に与えられる称号。'},
    '酎ハイ' => { image: 'chuhai.webp', description: '中央に金色のハイボールグラスが配置され、波と泡のパターンが施されており、酎ハイの爽やかで泡立つ性質を反映している。洗練された現代的なデザインとなっており、酎ハイ知識の最高峰に与えられる称号。'},
    'カクテル' => { image: 'cocktail.webp', description: '中央には金色のカクテルシェーカー、周囲にはマティーニグラス、マルガリータグラスなどのカクテルグラスが施されている。多様性と創造性を反映したデザインがカクテル知識の最高峰を表している。'}
    }
  end

  def appetizer_details
    {
    '和食' => { image: 'japanese.webp', description: '中央に寿司が描かれており、周囲には美しい桜の花、波模様、酒壺などが描かれている。日本料理の洗練された技術と文化的豊かさを祝福し、その最高峰の知識と専門性を持つ者に与えられる称号。'},
    '洋食' => { image: 'western.webp', description: '中央に金色のシェフの帽子が配置され、周囲にはステーキ、パスタ、パイなど、代表的な洋食料理が金色で描かれている。豪華で教養のあるデザインが、最高峰の知識と専門性を持つ者に与えられる称号。' },
    '中華' => { image: 'chinese.webp', description: '中央に金色の龍が配置され、周囲には餃子、麺類、北京ダックなどが描かれている。全体的に堂々とした複雑なデザインとなっており、最高峰の中華料理知識と専門性を持つ者に与えられる称号。'},
    '韓国' => { image: 'korean.webp', description: '中央には金色のキムチの瓶が配置され、その周囲には代表的な韓国料理が描かれている。全体的に文化的に豊かなデザインとなっており、韓国料理の最高峰の知識と専門性を持つ者に与えられる称号。'},
    'イタリアン' => { image: 'italian.webp', description: '中央に金色のスパゲッティが描かれており、周囲にはピザ、ティラミスなどが描かれている。周囲にはオリーブの枝とぶどうの葉の彫刻が施されており、イタリアンの達人に与えられる称号。'},
    'フレンチ' => { image: 'french.webp', description: '中央にコック・オー・ヴァンが描かれており、周囲にはクロワッサン、マカロン、ラタトゥイユなどが描かれている。全体的に装飾的なデザインであり、フレンチの達人に与えられる称号。'},
    'スペイン' => { image: 'spanish.webp', description: '中央に金色のパエリアが描かれており、周囲にはタパス、ガスパチョなどが描かれている。フラメンコダンサーやスペインのタイルパターンも描かれており、スペイン料理の達人に与えられる称号。'},
    'インド' => { image: 'indian.webp', description: '中央には金色のラムチョップが配置され、周囲にはビリヤニ、ナンなどが描かれている。日本料理の洗練された技術と文化的豊かさを祝福し、その最高峰の知識と専門性を持つ者に与えられる称号。'},
    'タイ' => { image: 'thai.webp', description: '中央には金色のパッタイが配置され、周囲にはグリーンカレー、トムヤムスープなどが描かれている。また、蓮の花や伝統模様のような装飾があり、タイ料理の知識を持つ者に与えられる称号。'},
    'メキシカン' => { image: 'mexican.webp', description: '中央に金色のタコスが配置され、周囲にはエンチラーダ、アボカド、サボテンなどが描かれている。メキシコならではの料理、植物が多く、メキシコ料理の知識を持つ者に与えられる称号。'}
    }
  end

  def display_alcohol_awards(alcohol_genre_counts, alcohol_details)
    qualified_genres = alcohol_genre_counts.select { |genre, count| alcohol_details[genre] && count >= 3 }
    return content_tag(:p, "取得した称号はありません。", class: "text-center mb-16") if qualified_genres.empty?

    content_tag(:div, class: "flex flex-wrap mb-16") do
      qualified_genres.map do |genre, count|
        content_tag(:div, class: "w-full lg:w-1/3 sm:w-1/2 p-4") do
          concat(
            content_tag(:div, class: "border-4 border-gray-500 bg-amber-50 shadow-xl rounded-lg p-4 h-full") do
              concat(content_tag(:p, "#{genre}マスター", class: "text-center font-bold mb-2"))
              concat(image_tag(alcohol_details[genre][:image], alt: "#{genre}称号", size: '270x270', class: 'border-4 border-gray-600 mb-2 mx-auto'))
              concat(content_tag(:div, alcohol_details[genre][:description], class: "bg-gray-100 border-2 border-yellow-600 text-xs max-w-72 mx-auto"))
            end
          )
        end
      end.join.html_safe  # 配列の各要素を連結して安全なHTMLとして出力
    end
  end

  def display_appetizer_awards(appetizer_genre_counts, appetizer_details)
    qualified_genres = appetizer_genre_counts.select { |genre, count| appetizer_details[genre] && count >= 3 }
    return content_tag(:p, "取得した称号はありません。", class: "text-center mb-16") if qualified_genres.empty?

    content_tag(:div, class: "flex flex-wrap mb-16") do
      qualified_genres.map do |genre, count|
        content_tag(:div, class: "w-full lg:w-1/3 md:w-1/2 p-4") do
          concat(
            content_tag(:div, class: "border-4 border-gray-500 bg-amber-50 shadow-xl rounded-lg p-4 h-full") do
              concat(content_tag(:p, "#{genre}マスター", class: "text-center font-bold mb-2"))
              concat(image_tag(appetizer_details[genre][:image], alt: "#{genre}称号", size: '270x270', class: 'border-4 border-gray-600 mb-2'))
              concat(content_tag(:div, appetizer_details[genre][:description], class: "bg-gray-100 border-2 border-yellow-600 text-xs"))
            end
          )
        end
      end.join.html_safe  # 配列の各要素を連結して安全なHTMLとして出力
    end
  end
end
