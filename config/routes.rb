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
  scope module: :users do
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    get 'post/hashtag/:name' => 'posts#hashtag'

    resources :users, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
    member do
      get :followings, :followers
    end
    end
    #DM機能
    resources :direct_messages, only: [:show, :create]
    #検索機能
    get 'search' => 'searches#search'
    # 問い合わせ機能
    resources :contacts, only: [:new, :create]
    get 'contacts/new/confirm' => 'contacts#confirm'
    get 'thanks' => 'contacts#thanks', as: 'thanks'
    # 通知機能
    resources :notifications, only: :index
  end
end
