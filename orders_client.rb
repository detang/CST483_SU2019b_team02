# Client code to include:
# - create a new order
# - retrieve an existing order by orderId, customerId, or customerEmail
# - register a new customer
# - lookup a customer by id or by email
# - create a new item
# - lookup/find an item by itemId

require 'httparty'
class OrderClient
    include HTTParty
    # item subdirectory: 8082
    # customer subdirectory: 8081
    # orders subdirectory: 8080
    base_uri "http://localhost:8080"
    
    # Create a new order
    def self.createOrder(order)
        post '/orders', body: order.to_json,
            headers: {'Content-Type' => 'application/json', 'ACCEPT'=>'application/json'}
    end
    
    # Get order by order Id, Customer Id or customer email
    def self.getOrder(verify, input)
        get "/orders?#{verify}=#{input}"
    end
    
    # Register a new customer
    def self.registerCustomer(customerHash)
        post '/customers', body: customerHash.to_json, 
        headers: {'Content-Type'=>'application/json', 'ACCEPT'=>'application/json'}
    end
    
    # Get customer by customer id or email
    def self .getCustomer(verify, input)
        get "/customers?#{verify}=#{input}"
    end
    
    # create a new item
    def self.createItem(item)
        post '/items', body: item.to_json, 
                headers: {'Content-Type'=>'application/json', 'ACCEPT'=>'application/json'}
    end
    
    # retreive the item by item ID
    def self.getItemById(id)
        @item = get "/item/#{id}"
    end
    
end

orderHash = Hash.new()
running=true
while running
    puts "What do you want to do:
            1) To create a new order enter: new order
            2) To retreive order details by Order ID, customer email or customer ID enter: get
            3) To register a new customer enter: register
            4) To look up a customer by customer ID or email enter: find
            5) To create a new item enter: new item
            6) To look up an item by Item ID enter: find item
            7) Quit - to exit"
    userInput = gets.chomp!
    if(userInput=='quit')
        running=false
        puts "bye"
        break;
        
    # User inputs data to create a new order    
    elsif userInput=='new order'
        puts "Please enter the item ID for the order"
        itemId = gets.chomp!
        
        puts "Please enter the customer email"
        custEmail = gets.chomp!
       
        orderHash = {itemId: itemId, email: custEmail}
        response = OrderClient.createOrder(orderHash)
       
        puts "status code #{response.code}"
        puts response.body
    
    # User inputs data to get order by ID, customer ID, or customer email
    elsif userInput == 'get'
        puts "To get order by:
                1) Order ID enter: id
                2) Customer ID enter: customer id
                3) Customer email enter: email"
        verify = gets.chomp!
        if verify == "id"
            puts "Please enter the order ID"
            input = gets.chomp!
        elsif verify == "customer id"
            puts "Please enter customer id:"
            input = gets.chomp!
        elsif verify == "email"
            puts "Please enter customer email:"
            input = gets.chomp!
        end
        response = OrderClient.getOrder(verify, input)
        puts "status code #{response.code}"
        puts response.body
    
    # User inputs details to register a customer    
    elsif userInput == "register"
        puts "\nPlease enter first name: "
        firstName = gets.chomp!
        
        puts "\nPlease enter last name: "
        lastName = gets.chomp!
        
        puts "\nPlease enter email: "
        email = gets.chomp!
        customerHash = {email: email, firstName: firstName, lastName: lastName}
        response = OrderClient.registerCustomer(customerHash)
        puts "status code #{response.code}"
        puts response.body
    
    # User inputs details to find a customer  
    elsif userInput =="find"
        puts "To get customer 
            1) By ID enter: id
            2) By email enter: email"
            verify = gets.chomp!
            if verify == "id"
                puts "Enter the customer ID"
                input = gets.chomp!
            elsif verify == "email"
                puts "Enter the customer email"
                input = gets.chomp!
            end
            # verify the customer details
            response = OrderClient.getCustomer(verify, input)
            puts "status code #{response.code}"
            puts response.body
    
    # User enters information to create a new item
    elsif userInput ==  "new item"
        puts "Please enter the item details"
        itemDetails = gets.chomp!
        puts "Enter the price"
        itemPrice = gets.chomp!
        puts "Enter the stock quantity"
        numOfStock = gets.chomp!
        itemHash = {description: itemDetails, price: itemPrice, stockQty: numOfStock}
        response = OrderClient.createItem(itemHash)
        puts "status code #{response.code}"
        puts response.body
        
    # User enters information to find an item by item ID
    elsif userInput =="find item"
        puts "Please enter the Item ID of the item you want to find:"
        itemId = gets.chomp!
        response = OrderClient.getItemById(itemId)
        puts response.code
        puts response.body
    end
end
        