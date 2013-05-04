# == Schema Information
#
# Table name: associate_producers
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  site       :string(255)
#  notes      :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class AssociateProducer < ActiveRecord::Base
  
  has_many :rooms
  has_many :sold_blocks
  has_many :payment_producer
  
  def amount_owing
    sold_blocks.sum(:compensation_due)
  end
  
  def amount_paid
    payment_producer.sum(:amount)
  end
  
end
