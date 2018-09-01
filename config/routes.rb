Rails.application.routes.draw do
  resources :blocks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :miner do
    get 'update_blockchain' => 'miner#update_blockchain'
    get 'add_new_block' => 'miner#add_new_block'
  end

end
