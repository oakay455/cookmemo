# cookmemo

## サイト概要
### サイトテーマ
料理に関するメモ、備忘録を投稿できるサイトです。<br>
他ユーザーの投稿も自由に閲覧でき、<br>
投稿に対していいねやコメントをしたり、ユーザーをフォローできます。<br>
自分の記録用としてだけではなく、料理のアイデア収集としても利用できます。<br>


### テーマの背景、サイトの特徴
「レシピ投稿」というと、細かい分量や作り方の説明が必要で<br>
投稿のハードルが高く感じてしまいますが、<br>
「メモ」と聞くと気軽に投稿できるのではないかと考え、<br>
サイト名は「cookmemo」とし、<br>
投稿フォーマットもシンプルで簡単に投稿できる仕様のサイトを制作しました。<br>
<br>
投稿時の入力箇所には、レシピのように「手順1、手順2…」といった入力指定はなく、<br>
自由に入力できるようにしています。<br>
「レシピ」の枠にとらわれず、<br>
料理のコツやアイデア、備忘録、など<br>
ユーザーの発想で自由に投稿していただき、<br>
料理にまつわるより多くのアイデアが集まるサイトになればと思っています。<br>


### ターゲットユーザ
- 料理に関する自分のメモを残したい人
- 料理のアイデアが欲しい人


### 主な利用シーン
- 料理のアイデアが欲しいとき
- 料理に関する備忘録を残したいとき


## 機能一覧
**ユーザー側**
- ユーザー認証機能
- ゲストログイン機能
- マイページ
- 料理メモ投稿・編集・削除
- 投稿の閲覧（詳細画面、一覧画面）
- 投稿検索機能（キーワード、カテゴリー）
- ユーザー検索機能
- いいね機能（非同期）
- コメント機能(非同期)
- ブックマーク機能（非同期）
- フォローフォロワー機能

**管理者側**
- 管理者認証機能
- 会員管理
- コメント管理
- カテゴリ作成,編集,削除

**その他**
- レスポンシブ対応


## 設計書
- ER図：https://drive.google.com/file/d/163B91BXbjXKNeHCM29y5ZgaOG2tKe4U4/view?usp=sharing
- テーブル定義書：https://docs.google.com/spreadsheets/d/1gJiZ7CirlIppbPuitzuTtQWYFr4y_8T2/edit?usp=sharing&ouid=115404509093594789086&rtpof=true&sd=true
- 詳細設計：https://docs.google.com/spreadsheets/d/1NBaOkjWZpX2PBwbK-S16wm30bI8Rf5cm/edit?usp=sharing&ouid=115404509093594789086&rtpof=true&sd=true

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
- レイアウト:Bootstrap 5.0.2
- Fontawesome 6.1.1

## 使用素材
- Unsplash. https://unsplash.com/
- Foodiesfeed  https://www.foodiesfeed.com/
- photoAC https://www.photo-ac.com/