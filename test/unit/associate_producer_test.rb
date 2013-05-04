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

require 'test_helper'

class AssociateProducersTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
