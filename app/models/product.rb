# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  reference   :string
#  price       :decimal(, )
#  quantity    :integer
#  brand       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
	validates :name, :reference, :price, :quantity, :brand, :category_id, presence: true
	validates :price, numericality: true
	validates :quantity, numericality: { only_integer: true }
	validates :quantity, :price, numericality: { greater_or_equal_to: 0}

	#associatons

	belongs_to :category
end
