Rails.application.routes.draw do
  root 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #adminはサインインだけ
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }
  namespace :admins do
    resources :users, only: %i[index show edit update]
  end

  scope module: :users do
    # 投稿機能
    resources :posts do
      # 投稿コメント機能
      resources :post_comments, only: %i[create destroy]
      # 投稿いいね機能
      resource :likes, only: %i[create destroy]
      # カテゴリー検索機能
      collection do
        get 'top'
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
      end
      member do
        get 'search'
      end
      #お気に入り一覧
      get 'likes'
    end
    # ハッシュタグ機能
    get 'post/hashtag/:name' => 'posts#hashtag'
    # カテゴリー一覧
    resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
    
    
    # ユーザー機能
    resources :users, only: %i[index show edit update] do
      #フォローフォロワー機能
      resource :relationships, only: %i[create destroy]
      member do
        get :followings, :followers
      end
    end
    #DM機能
    resources :direct_messages, only: %i[create index show]
    #検索機能
    get 'search' => 'searches#search'
    # 問い合わせ機能
    resources :contacts, only: %i[new create]
    get 'contacts' => 'contacts#new'
    get 'contacts/confirm' => 'contacts#confirm'
    get 'thanks' => 'contacts#thanks', as: 'thanks'
    # 通知機能
    resources :notifications, only: [:index]
    #スケジュール機能
    resources :events
    get 'my_calendar' => 'events#my_calendar'
  end
end
