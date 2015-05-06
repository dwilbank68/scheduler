Rails.application.routes.draw do

  devise_for :users
  get 'welcome/index'

  get 'welcome/about'


  root 'units#index'


  get 'units/:id/report_status' => 'units#report_status'
  get 'units/report_unit_statuses' => 'units#report_unit_statuses'

  resources :users

   resources :units do
     resources :unit_users
   end

  resources :unit_users, only: [:update, :destroy]

  post 'twilio/voice' => 'twilio#voice'

end
