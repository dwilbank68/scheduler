Rails.application.routes.draw do

  devise_for :users
  get 'welcome/index'

  get 'welcome/about'

  root 'units#index'

  get 'units/:id/report_status' => 'units#report_status'
  get 'units/report_unit_statuses' => 'units#report_unit_statuses'
  get 'units/unit_statuses' => 'units#unit_statuses'

  get 'users/get_users' => 'users#get_users'

  put 'unit_users/:id/update_duration' => 'unit_users#update_duration'
  put 'unit_users/:id/update_note' => 'unit_users#update_note'
  put '/users/:id/update_contact_prefs' => 'users#update_contact_prefs'

  resources :users
  # post '/users/:id' => 'users#update_contact_prefs'

   resources :units do
     resources :unit_users, except: [:destroy, :new, :edit, :show]
   end

  resources :unit_users, only: [:update, :destroy]

  post 'twilio/voice' => 'twilio#voice'

end
