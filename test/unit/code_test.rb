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

require 'test_helper'

class CodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
