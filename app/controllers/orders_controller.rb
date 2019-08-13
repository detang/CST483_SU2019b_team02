class OrdersController < ApplicationController
	#POST /orders
	def create
		puts params
		@orders = Item.new
		@orders.itemId = params[:itemId]
		@orders.customerId = params[:customerId]
		@orders.email = params[:email]
		if @orders.save
			render(status: 200, json: @orders.to_json)
		else
			head 400
		end
	end

	#GET /orders/id=:id
	def getOrder
		order = Order.find_by(id: params[:itemId])
		if order.nil?
			render json: { error: "Can not locate order. #{params[:id]}"}, status: 404
		else
			render json: order, status: 200
		end
	end
	
	#GET /orders?customerId=nnn
	def customerOrders
		customId = Order.find_by(id: params[:customerId])
		if customId.nil?
			render json: { error: "Can not locate order for that customer. #{params[:customerId]}"}, status: 404
		else
			render json: order, status: 200
		end
	
	end
	
	#GET /orders?email=nn@nnnn
	def emailOrders
		email = Order.find_by(email: params[:email])
		if email.nil?
			render json: { error: "Can not locate order with that email. #{params[:email]}"}, status: 404
		else
			render json: order, status: 200
		end
	end
	
end
