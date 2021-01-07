Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/transaction'
  post 'transactions/do_transaction'
  get 'transactions/transfer'
  post 'transactions/transfer'

  get 'account/reports'
  get 'account/amount'
  #get 'account/new'
  post 'account/create'
  #get 'account/update'
  #get 'account/swtich'
  devise_for :users
  resources :account
  resources :transactions
  #resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
