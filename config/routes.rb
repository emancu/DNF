ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"

  map.resource :account, :controller => "users"
  map.resources :users

  map.resources :lists, :has_many => :tasks

end
