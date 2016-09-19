Spina::Engine.routes.draw do
  namespace :admin do
    resources :projects
  end
  resources :projects, only: [:show, :index]
end
