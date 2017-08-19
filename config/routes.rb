Rails.application.routes.draw do
  root 'home#index'
  resources :thanks
  get '/login' => 'admins#sign_in_page', as: :signin
  post '/login' => 'admins#sign_in'
  get '/admin' => 'thanks#edit', as: :admin
end
