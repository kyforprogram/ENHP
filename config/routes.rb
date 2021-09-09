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

scope module: :user do
    resources :posts
  end
end
