Mav1::Application.routes.draw do
  patch "settings", to: 'users#edit'
  get "settings", to: 'users#show'
  get "landing_page/index" 
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
    #skip: [:registrations]

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

  resources :dashboard, :only => [:index] do
      collection do
          get :resolve
          post :resolve, as: 'postresolve'
          get :short
          post :short, as: 'postshort'
      end
  end
  get "dashboard/delete"

  resources :employees do
      collection do
          get :import
          post :import
      end
  end
  #authenticated :user do
    #root :to => 'dashboard#index'
  #end
  root :to => 'dashboard#index'
end
