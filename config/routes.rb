Rails.application.routes.draw do

  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root 'units#index'

  get 'units/:id/report_status' => 'units#report_status'
  get 'units/report_unit_statuses' => 'units#report_unit_statuses'
  get 'units/unit_statuses' => 'units#unit_statuses'

  put 'unit_users/:id/update_duration' => 'unit_users#update_duration'
  put 'unit_users/:id/update_note' => 'unit_users#update_note'

  resources :users

   resources :units do
     resources :unit_users
   end

  resources :unit_users, only: [:update, :destroy]

  post 'twilio/voice' => 'twilio#voice'

end
