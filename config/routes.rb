Rails.application.routes.draw do
  devise_for :users
	resources :categories
    resources :products
    resources :purchases
    root 'pages#home'
    #get 'welcome' => 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
