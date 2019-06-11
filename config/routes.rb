Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/bitcoin', to: 'bitcoin#get_block_count', as: 'bitcoin_get_block_count'

  get '/neo', to: 'neo#get_block_count', as: 'neo_get_block_count'

  get '/ethereum', to: 'ethereum#get_block_count', as: 'ethereum_get_block_count'

  get '/rabbitmq', to: 'rabbitmq#send_message', as: 'rabbitmq_send_message'
end
