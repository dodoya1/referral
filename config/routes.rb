Rails.application.routes.draw do
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"
  # "users/:id/likes"に対応するルーティングを追加してください
  get "users/:id/likes" => "users#likes"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  
  
  #つながり申請。idはリクエストされる側の情報。
  post "connects/:id/requesting" => "connects#requesting"
  #idはリクエストされた側のid。
  get "users/:id/requested" => "users#requested"
  #つながり承認リンク。idはリクエストした側のid。「id=requesting_id」。
  post "connects/:id/allow" => "connects#allow"
  #つながり拒否リンク。idはリクエストした側のid。「id=requesting_id」。
  post "connects/:id/refuse" => "connects#refuse"
  #繋がっているユーザー一覧。
  get "users/:id/connected" => "users#connected"
  
  
  #「推薦コメント」ページに飛べるかどうか。つまり、繋がりがあるかどうか確認する。idは、推薦コメントを書かれる側。
  get "recommends/:id/connecting" => "recommends#connecting"
  #「推薦コメント」ページ。idは、推薦コメントを書かれる側。
  get "recommends/:id/comment" => "recommends#comment"
  #推薦コメントを作成する。(Recommendテーブルにデータを新規作成する)
  post "recommends/:id/create" => "recommends#create"
  #「推薦コメント」一覧ページ。
  get "users/:id/recommends" => "users#recommends"
  #「推薦コメント」削除機能。
  post "recommends/:id/destroy" => "recommends#destroy"
  #「推薦コメント」詳細ページ。
  get "recommends/:id" => "recommends#show"
  
  
  
  #自己紹介ページ。
  get "users/:id/profile" => "users#profile"
  #自己紹介新規登録ページ。
  get "profiles/new" => "profiles#new"
  #自己紹介編集ページ。idは、ユーザーid。user_idに用いられる。
  get "profiles/:id/edit" => "profiles#edit"
  #自己紹介新規登録をする。アクション。
  post "profiles/create" => "profiles#create"
  #自己紹介編集をする。アクション。idは、ユーザーid。user_idに用いられる。
  post "profiles/:id/update" => "profiles#update"
  
  
  #求人投稿ページ。
  get "offers/new" => "offers#new"
  #求人投稿をする。アクション。
  post "offers/create" => "offers#create"
  #求人投稿一覧ページ。
  get "offers/index" => "offers#index"
  #求人投稿詳細ページ。
  get "offers/:id" => "offers#show"
  #「話を聞きたい」機能。アクション。「:id」は、Offerテーブルのid。
  post "interests/:id/create" => "interests#create"
  #求人投稿編集ページ。
  get "offers/:id/edit" => "offers#edit"
  #求人編集をする。アクション。
  post "offers/:id/update" => "offers#update"
  #求人投稿を削除する。アクション。
  post "offers/:id/destroy" => "offers#destroy"
  #あるユーザーの求人投稿一覧。
  get "users/:id/offers" => "users#offers"
  
  
  #すでにユーザー同士のルームがあるか調べる。idはユーザーid。
  get "rooms/:id/investigating" => "rooms#investigating"
  #チャットルーム。view。idはroomのid。
  get "rooms/:id/index" => "rooms#index"
  #チャットメッセージ送信機能。idはroomのid。Chatテーブルに新規作成時に必要。アクションのみ。
  post "chats/:id/create" => "chats#create"
  #チャットルーム一覧。view。idは自分のユーザーid。
  get "users/:id/rooms" => "users#rooms"
  
  
  
  
  

  get "/" => "home#top"
  get "about" => "home#about"
end