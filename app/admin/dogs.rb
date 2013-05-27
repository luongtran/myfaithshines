ActiveAdmin.register Dog do
  menu :priority => 6
  config.comments = false
  
  form :html => { :enctype => "multipart/form-data" } do |f|
     f.inputs "Details" do
      f.input :name
 #     f.input :gender, :as => :select, :include_blank => false
      f.input :home
      f.input :age
 #     f.input :motto
      f.input :more
 #     f.input :dog_type, :as => :select, :include_blank => false
      f.input :image, :as => :file
    end
    f.actions
  end
  
  
  index do
    column :id 
    column :name
    column :age
    column :home
 #   column :motto do |dog|
 #      dog.more.nil? ? '' : truncate(dog.motto.html_safe, :length => 50)  
 #   end   
    column :more do |dog|
      dog.more.nil? ? '' : truncate(dog.more.html_safe, :length => 100)  
   end
 
   default_actions
  end 
  
end
