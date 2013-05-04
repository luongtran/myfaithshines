# == Schema Information
#
# Table name: dog_types
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class DogType < ActiveRecord::Base
  
  def self.not_virtual
    DogType.find(:all, :conditions=> ["not(lower(name) like ?)",'%virtual%'])
  end
  
  def self.virtual
    DogType.find(:first, :conditions=> ["lower(name) like ?",'%virtual%'])
  end
  
  def self.mydog
    DogType.find(:first, :conditions=> ["lower(name) like ?",'%my dog%'])
  end
  
  def self.memorial
    DogType.find(:first, :conditions=> ["lower(name) like ?",'%dead%'])
  end
end
