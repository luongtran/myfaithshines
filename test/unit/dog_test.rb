# == Schema Information
#
# Table name: dogs
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  link               :string(255)
#  gender_id          :integer(4)
#  age                :integer(4)
#  home               :string(255)
#  motto              :string(255)
#  more               :text
#  dog_type_id        :integer(4)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#

require 'test_helper'

class DogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
