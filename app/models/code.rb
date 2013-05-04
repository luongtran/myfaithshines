# == Schema Information
#
# Table name: codes
#
#  id             :integer(4)      not null, primary key
#  code_value     :string(255)
#  sponsor_id     :integer(4)
#  non_profit_id  :integer(4)
#  code           :string(255)
#  code_type      :string(255)
#  total_value    :integer(4)
#  redeem_value   :integer(4)
#  redeemed       :integer(4)
#  active         :boolean(1)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  aff_assoc_id   :integer(4)
#  aff_assoc_type :string(255)
#

class Code < ActiveRecord::Base
   belongs_to :sponsor
   belongs_to :non_profit
   belongs_to :associate_producer
   has_many :room_codes
   has_many :rooms, :through => :room_codes
   
   validates_uniqueness_of :code_value, :case_sensitive => false
end
