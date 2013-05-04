# == Schema Information
#
# Table name: non_profits
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  site       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  state_id   :integer(4)
#

require 'test_helper'

class NonProfitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
