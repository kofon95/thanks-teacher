Rails.application.routes.draw do
  root 'home#index'
  resources :thanks
  match '/login' => 'admins#sign_in_page', via: :get, as: :signin
  match '/login' => 'admins#sign_in', via: :post
  match '/admin' => 'thanks#edit', via: :get, as: :admin
  match '/admin' => 'admins#sign_out_current', via: :delete
end
