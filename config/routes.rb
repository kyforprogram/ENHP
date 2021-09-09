Rails.application.routes.draw do
  namespace :users do
    get 'users/show'
    get 'users/index'
    get 'users/edit'
    get 'users/update'
  end
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
    end
    resources :users, only: [:index, :show, :edit, :update]
  end

end
