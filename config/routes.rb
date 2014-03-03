Mav1::Application.routes.draw do
  resources :leaves

  get "dashboard/index"
  resources :employees do
      collection do
          get :import
          post :import
      end
  end

  resources :shifts

  root :to => 'dashboard#index'
end
