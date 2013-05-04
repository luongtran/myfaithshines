# == Schema Information
#
# Table name: sponsors
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  site       :string(255)
#  state_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class SponsorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
