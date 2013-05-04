ActiveAdmin.register User do
  menu :priority => 2, :parent => 'Users', :label => 'Web Users'
  config.comments = false

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
    end
    f.actions
  end
  
  index do
    column :id  
    column :email
    column :encrypted_password
    column :reset_password_token
    column :reset_password_sent_at  
    column :remember_created_at
    column :sign_in_count
    column :current_sign_in_ip
    column :last_sign_in_ip  
    column :created_at
    column :updated_at
   
    column :links do |users|
      links = ''.html_safe
      if controller.action_methods.include?('show') 
        links += link_to I18n.t('active_admin.view'), resource_path(users), :class => "member_link view_link"
      end
      if controller.action_methods.include?('edit') 
        links += link_to I18n.t('active_admin.edit'), edit_resource_path(users), :class => "member_link edit_link"
      end
      if controller.action_methods.include?('destroy') 
        links += link_to I18n.t('active_admin.delete'), resource_path(users), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      end     
        links += link_to "Send Email", admin_send_mail_path(:addresses => users.email), :class => "member_link send_mail_link"
      
      links
    end
  end 
 
end
