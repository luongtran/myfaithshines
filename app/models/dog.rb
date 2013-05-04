# == Schema Information
#
# Table name: dogs
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
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

class Dog < ActiveRecord::Base
  has_attached_file :image, :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :styles => {
      :thumb => "120x120>" },
    :convert_options => {
      :thumb => "-quality 75 -strip" }
      
  
  belongs_to :dog_type
  belongs_to :gender
  
  validates_attachment_size :image, :less_than => 6144.kilobytes, :message => "Image max size is 6MB"
  validates_presence_of :name, :message => "The dog should have a name"
  
  def self.getRandomVirtual
    Dog.where("dog_type_id = :dog_type_id", {:dog_type_id => DogType.virtual.id}).random(10)
  end
  
  def age_formatted
    age_str = ""
    if !self.age.nil? && !self.age.to_s.blank? && self.age > 0
      age_str += self.age.to_s + " " + 'year'.pluralize(self.age)
    end
  end

end
