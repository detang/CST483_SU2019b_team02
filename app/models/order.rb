class Order < ApplicationRecord
	  validates :itemId, presence: true
      validates :description, presence: true
      validates :customerId, presence: true
      validates :price, numericality: { greater_than: 0 }
end
