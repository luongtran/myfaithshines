ActiveAdmin.register Sponsor do
  menu :priority => 3
  config.comments = false
  

  form :html => { :enctype => "multipart/form-data" } do |f|
     f.inputs "Details" do
      f.input :state, :as => :select, :include_blank => false
      f.input :name
      f.input :email
      f.input :site   
      f.input :image, :as => :file, :hint => f.template.image_tag(f.object.image.url()) 
      f.input :featured    
      f.input :category, :as => :select, :collection => ["Boonie Dog","Lucky Dog","Working Dog","Hot Dog","Big Dog", "Top Dog",'"THE" Dog' ], :include_blank => false           
    end   
    f.inputs "Non profits" do 
       f.hacked_has_many :profit_sponsor, :name=>'Non Profits' do |ps_f|
          ps_f.inputs do          
            ps_f.input :non_profit, :include_blank => false
            ps_f.input :_destroy, :as =>:boolean, :required => false, :label => 'Remove'               
          end  
                
       end 
    end  
       
    f.actions
  end

  
  index do
    column :id  
    column :name
    column :email
    column :site
    column :created_at
    column :updated_at
    column :image_file_name
    column :featured
    column :category
     
    column :links do |sponsors|
      links = ''.html_safe
      if controller.action_methods.include?('show') 
        links += link_to I18n.t('active_admin.view'), resource_path(sponsors), :class => "member_link view_link"
      end
      if controller.action_methods.include?('edit') 
        links += link_to I18n.t('active_admin.edit'), edit_resource_path(sponsors), :class => "member_link edit_link"
      end
      if controller.action_methods.include?('destroy') 
        links += link_to I18n.t('active_admin.delete'), resource_path(sponsors), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      end     
        links += link_to "Send Email", admin_send_mail_path(:addresses => sponsors.email), :class => "member_link send_mail_link"
      
      links
    end
  end 
  
  show do  
    attributes_table do
       row :id
       row :state  
       row :name
       row :email 
       row :site
       row :featured
       row "Image" do |sponsor| 
        link_to(image_tag(sponsor.image.url(), :height => '100'))
      end  
     end
         
    panel "Non Profits" do
       table_for sponsor.profit_sponsor do
         column do |appointment|
           appointment.non_profit.name
         end     
       end    
    end
  
end
   
end
