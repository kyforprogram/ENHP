Rails.application.routes.draw do
root "homes#top"
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}
end
