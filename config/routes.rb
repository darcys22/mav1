Mav1::Application.routes.draw do
  get "week/index", as: 'week'
  get "week/import"
  get "week/new"
  post "week/import"
  get "week/delete"
  get "week/renderer", as: 'render'

  #resources :week, :only => [:index, :new, :delete] do
    #collection do
      #get :import
      #post :import
      #get :renderer, as: 'render'
    #end
  #end

  resources :leaves

  resources :dashboard, :only => [:index]
  get "dashboard/delete"

  resources :employees do
      collection do
          get :import
          post :import
      end
  end

  root :to => 'dashboard#index'
end
