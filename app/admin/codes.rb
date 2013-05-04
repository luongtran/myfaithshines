ActiveAdmin.register Code do
  menu :priority => 4
  config.comments = false
 
 
 form :html => { :enctype => "multipart/form-data" } do |f|
     f.inputs "Details" do
      f.input :sponsor, :as => :select 
      f.input :non_profit, :as => :select 
      f.input :associate_producer, :as => :select
      f.input :code_value, :label => "Code Name"
      f.input :total_value
      f.input :redeem_value
      f.input :redeemed
      f.input :active
    end
    f.actions
  end
 
   index do
    column :id 
    column "Code Name", :code_value
    column :total_value
    column :redeem_value
    column :redeemed
    column :active
    column :created_at
    column :updated_at
 
   default_actions
  end 
  
  show do  |code|
    attributes_table do
       row :id
       row 'Code Name' do code.code_value end
       row :sponsor
       row :non_profit
       row :total_value
       row :redeem_value  
       row :redeemed  
       row :active  
       row :created_at  
       row :updated_at    
       row :associate_producer    
     end
  end   
  
end
