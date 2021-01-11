Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/transaction'
  post 'transactions/do_transaction'
  get 'transactions/transfer'
  post 'transactions/transfer'

  #get 'account/reports'
  #get 'account/amount'
  #get 'account/new'
  #get 'account/index'
  #get 'account/update'


  devise_for :users

  resources :transactions do
    collection do
      get 'get_tax'
    end
  end

  resources :accounts do
    collection do
      get 'reports'
      get 'amount'
      get 'index' 
    end

    member do
      get 'switch'
    end
    
  end
  #resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
