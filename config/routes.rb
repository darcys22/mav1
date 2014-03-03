Mav1::Application.routes.draw do
  get "week/index", as: 'week'
  get "week/import"
  get "week/new"
  post "week/import"
  get "week/delete"
  resources :leaves

  get "dashboard/index"
  resources :employees do
      collection do
          get :import
          post :import
      end
  end

  root :to => 'dashboard#index'
end
