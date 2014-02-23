Mav1::Application.routes.draw do
  resources :leaves

  get "dashboard/index"
  resources :employees do
      collection { post :import }
  end

  resources :shifts

  root :to => 'dashboard#index'
end
