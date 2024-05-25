# サービス名： [酒菜ネット](https://www.sakana-net.com/)
[![Image from Gyazo](https://i.gyazo.com/394eb30ba3b02dd836cd813513253eee.png)](https://www.sakana-net.com/)

## ■サービス概要
晩酌はどんなメニューにしようか悩むという方、よく合うお酒とおつまみの組合せを知りたい方、晩酌がマンネリ化している方に向けたお酒・おつまみの情報共有サービスです。
ユーザーの投稿内容と、AIによる組合せの提案から様々なお酒・おつまみとその組合せに出会うことができます。
晩酌・飲み会を、より豊かに。酒菜ネットは多くの人にお酒・おつまみの魅力が伝わるようにサポートします。

## ■ このサービスへの思い・作りたい理由
本サービスを作成するにあたって、以下２つの経験をもとに着想を得ました。

`1.いつも同じお酒を飲んだり、似たようなメニューの繰り返しでマンネリ化してしまう`<br>
`2.普段家や店でお酒を飲まないという友人や知人が多く、もっとお酒・おつまみの魅力を伝えたい`

本サービスでは、上記のような経験のある方に、お酒、おつまみの新しい発見、魅力を共有していただき、
ユーザー間で気軽にコミュニケーションをとったり、1人でツールのように活用することを目的としています。

## ■ サービスの差別化ポイント・推しポイント
クックパッドのようなアプリはレシピを提供するのに対し、本サービスはお酒、おつまみの組み合わせに特化したアイデアを提供します。
お酒、おつまみのようにジャンルを限定することで、お酒、おつまみが好きなユーザー、興味のあるユーザーが利用することが予想でき、
質の高い有益な情報が集まりやすいと考えます。

## ■ 機能紹介
|トップ画面|ログイン機能|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/4e42b99404d3134eacbfa74997982f53.gif)](https://gyazo.com/4e42b99404d3134eacbfa74997982f53)|[![Image from Gyazo](https://i.gyazo.com/0329bb6549e2c93b2617fc188ae4dc58.png)](https://gyazo.com/0329bb6549e2c93b2617fc188ae4dc58)|
|使い方説明では、それぞれに該当ページまたはそれに近いページへのリンクを設置し、慣れてない方でも操作しやすいようにしました。|なるべく多くのユーザーに登録いただけるように、Email、Google、LINEの3つのログイン方法を実装しました。|

|投稿一覧|投稿|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/6d2e0d5b4890d1e75f9e1a3f917b4511.gif)](https://gyazo.com/6d2e0d5b4890d1e75f9e1a3f917b4511)|[![Image from Gyazo](https://i.gyazo.com/5d2dbc85b421326b71399b9c3afebc8c.gif)](https://gyazo.com/5d2dbc85b421326b71399b9c3afebc8c)|
|ユーザーが投稿したお酒&おつまみの投稿一覧です。タイトル・本文、お酒のジャンル、おつまみのジャンルで検索できます。|お酒&おつまみの投稿フォームです。店名はオートコンプリートで候補から選択できるようにしました。|

|投稿詳細|AI組合せ|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/3091a9a7fcd06c379d353d892c53cb3c.gif)](https://gyazo.com/3091a9a7fcd06c379d353d892c53cb3c)|[![Image from Gyazo](https://i.gyazo.com/3db1c34c544e49fa75cfde746ead8a27.gif)](https://gyazo.com/3db1c34c544e49fa75cfde746ead8a27)|
|投稿一覧ページから投稿を選択すると、詳細情報を確認できます。投稿編集・削除、X・LINE共有、いいね、地図確認、コメントができます。|お酒と3つの食材を選択すると、OpenAIが3つの食材を使った、お酒に合うおつまみを提案します。|

|AI組合せの回答結果|マイページ|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/466721182ae16a69202106f177bf1832.png)](https://gyazo.com/466721182ae16a69202106f177bf1832)|[![Image from Gyazo](https://i.gyazo.com/00c708a9a477a03f899ca7a13a58a18c.gif)](https://gyazo.com/00c708a9a477a03f899ca7a13a58a18c)|
|お酒、おつまみの組合せ解説、使用材料、作り方が表示されます。X、LINEでの共有ができます。|マイページから、過去の投稿一覧、いいねした投稿一覧、AI組合せ一覧、プロフィール設定にアクセスできます。|

|称号|プロフィールページ|
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/0a62bb759b52eecef2f831014391bc8c.gif)](https://gyazo.com/0a62bb759b52eecef2f831014391bc8c)|[![Image from Gyazo](https://i.gyazo.com/2dd2bda3bc0c942ef097a2dadec81f0a.gif)](https://gyazo.com/2dd2bda3bc0c942ef097a2dadec81f0a)|
|ジャンル毎に投稿数が3以上になると称号を獲得できます。マイページで獲得した称号を確認できます。称号の合計が2以上で銀、4以上で金の王冠が名前の横に表示されます。|投稿一覧のユーザー名を選択すると、他者のプロフィールページにアクセスできます。マイページとほぼ同様です。|

## ■ 使用技術
|カテゴリ|技術|
|:-------------|:------------|
|フロントエンド|TailwindCSS, daisyUI, JavaScript, Rails 7.0.8(Hotwire/Turbo)|
|バックエンド|Ruby 3.2.2, Rails 7.0.8|
|データベース|PostgreSQL|
|開発環境|Docker|
|インフラ|Render|
|Web API|Open AI(GPT-4-turbo), Google Maps, Google Sign-In, LINE Login|
|その他|Amazon S3|

## ER図
[![Image from Gyazo](https://i.gyazo.com/48525e956172aa6aa854d038dacd8f55.png)](https://gyazo.com/48525e956172aa6aa854d038dacd8f55)

## 画面遷移図(設計時)
https://www.figma.com/file/zbN5SVC7FRK5g46pMPRmUC/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=H6spxD558HZYnSwa-1

## ■ 今後の展望
リファクタリングやRspecでのテストを行い、メンテナンス性、品質、安全性を向上させる予定です。