Rails.application.routes.draw do
  	
  	root 'pages#home'
  	devise_for :users
	 resources :categories
    resources :products
    resources :purchases
    
    get 'profile' => 'pages#profile'

    get 'dashboard' => 'purchases#dashboard'

   
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end


    #get 'welcome' => 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
