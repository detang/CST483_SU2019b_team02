Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	post '/orders', to: 'orders#create'
    get 'orders/:id', to: 'orders#getOrder'
    get '/orders?customerId=nnn', to: 'orders#customerOrders'
    get '/orders?email=nn@nnnn', to: 'orders#emailOrders'
end
