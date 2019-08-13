class OrdersController < ApplicationController
	#POST /orders
	def create
		puts params
		@orders = Item.new
		@orders.itemId = params[:itemId]
		@orders.email = params[:email]
		if @orders.save
			render(status: 201, json: @orders.to_json)
		else
			head 400
		end
	end

	#GET /orders/id=:id
	def getOrder
	end
	
	#GET /orders?customerId=nnn
	def customerOrders
	end
	
	#GET /orders?email=nn@nnnn
	def emailOrders
	end
	
end
