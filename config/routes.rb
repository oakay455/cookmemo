Rails.application.routes.draw do
  get 'searches/search'
  # 会員用device
# URL /members/sign_in ...
devise_for :members,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#ゲストユーザーログイン
devise_scope :member do
  post 'members/guest_sign_in', to: 'members/sessions#guest_sign_in'
end

# 管理者用device
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



# 管理者側ルーティング

namespace :admin do
root to: 'homes#top'
get "search" => "searches#search", as: 'search'
resources :members, only: [:index,:show,:edit,:update] do
   get 'recipe_index' => 'members#recipe_index'
end
resources :categories, except: [:new, :show]
resources :posts, only: [:index, :show, :edit, :update]
resources :recipes, only: [:index, :show, :edit, :update]
end


# 会員側ルーティング

scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'search' => 'searches#search', as: 'search'

 resources :members do
     resource :relationships, only:[:create, :destroy]
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
     get 'myrecipe' => 'members#myrecipe', as: 'myrecipe'
     get 'myalbum' => 'members#myalbum', as: 'myalbum'
     member do
     get :bookmarks #特定のidが必要なため、memberメソッド使用
    end
end


# 退会確認画面、論理削除用のルーティング
 get '/members/:id/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
 patch '/members/:id/withdraw' => 'members#withdraw', as: 'withdraw'

 resources :recipes do
   resources :recipe_favorites, only: [:create, :destroy]
   resources :comments, only:[:create, :destroy]
   resources :bookmarks, only:[:create, :destroy]
   get :search, on: :collection
  end

 resources :posts do
   resource :favorites, only: [:create, :destroy]
  end

  end


 end