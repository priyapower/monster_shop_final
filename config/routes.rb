# Module 3 requires you to know URLs, paths and HTTP verbs inside and out. Rewrite the routes file for your Monster Shop to use only methods that map directly to HTTP verbs: get, post, put, patch and delete. You will probably need to add to: and as: parameters to make sure your apps continue to work, and tests continue to pass.
#  - Rewrite your Monster Shop routes.rb:
#  - If you wrote your routes that way already, replace them using resources.
#  - If you do not own the repo for your project, fork it, and rewrite the routes file individually.

Rails.application.routes.draw do
  resources :welcome, :path => "/", only: :index

  resources :merchants do
    resources :items, only: [:index]
  end

  resources :items, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  resource :cart, only: [:show], controller: "cart" do
    post ':item_id', :action => 'add_item'
    delete '', :action => 'empty'
    patch ':change/:item_id', :action => 'update_quantity'
    delete ':item_id', :action => 'remove_item'
  end

  scope controller: :users do
    get 'registration' => :new, as: :registration
    patch '/user/:id' => :update
    get '/profile' => :show
    get '/profile/edit' => :edit
    get '/profile/edit_password' => :edit_password
  end

  resources :users, only: [:create, :update]

  scope controller: :orders, module: 'user' do
    post '/orders' => :create
    get '/profile/orders' => :index
    get '/profile/orders/:id' => :show
    delete '/profile/orders/:id' => :cancel
  end

  scope controller: :sessions do
    get '/login' => :new
    post '/login' => :login
    get '/logout' => :logout
  end

  namespace :merchant do
    resources :dashboard, :path => "/", only: :index
    resources :orders, only: :show
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    resource :items do
      put ':id/change_status', action: :change_status
    end
    resource :orders do
      get '/:id/fulfill/:order_item_id' => :fulfill
    end
    resources :discounts, only: [:index, :show, :new, :create, :edit, :destroy, :update]
    resource :discounts do
      patch '/:status/:id' => :update_status
    end
  end

  namespace :admin do
    resources :dashboard, :path => "/", only: :index
    resources :merchants, only: [:show, :update]
    resources :users, only: [:index, :show]
    resource :orders do
      patch '/:id/ship' => :ship
    end
  end
end
