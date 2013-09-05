ActiveAdmin.register NonProfit do
  menu :priority => 2
  config.comments = false
  config.sort_order = 'name_asc'
  
  controller do
    def destroy
      np = NonProfit.find(params[:id])
      np.delete
      redirect_to admin_non_profits_path
    end
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
      f.inputs "Details" do
      f.input :state, :as => :select, :include_blank => false
      f.input :name
      f.input :email
      f.input :site
	    f.input :zipcode
	    f.input :address
      #f.input :payment_received
      f.input :non_profit_type, :as => :select, :include_blank => false
      f.input :status, :as => :select, :collection => Array.[]('New', 'Inprogress', 'Verified'), :include_blank => false
      f.input :logo, :as => :file, :hint => f.object.logo.blank? ?  f.template.content_tag(:span, "No Image Yet") : f.template.image_tag(f.object.logo.url()) 
    end
    f.actions
  end
  
   
  
  index do
    column :id  
    column :name
    column :email
    column :site
	  column :zipcode
    #column :payment_received
    column :created_at
    column :updated_at
   # column :snapshot_file_name
   # column :snapshot_updated_at
    column :links do |non_profit|
      links = ''.html_safe
      if controller.action_methods.include?('show') 
        links += link_to I18n.t('active_admin.view'), resource_path(non_profit), :class => "member_link view_link"
      end
      if controller.action_methods.include?('edit') 
        links += link_to I18n.t('active_admin.edit'), edit_resource_path(non_profit), :class => "member_link edit_link"
      end
      if controller.action_methods.include?('destroy') 
        links += link_to I18n.t('active_admin.delete'), resource_path(non_profit), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      end     
        links += link_to "Blocks", blocks_admin_non_profit_path(non_profit), :class => "member_link blocks_link"
        links += link_to "Send Email", admin_send_mail_path(:addresses => non_profit.email), :class => "member_link send_mail_link"
      
      links
    end
  end  
  
  
  show do
    attributes_table do
      row :id  
      row :name
      row :email
      row :site
      row :state
	    row :zipcode
      #row :payment_received
      row :non_profit_type
      row :created_at
      row :updated_at
   #   row :snapshot_file_name
   #   row :snapshot_file_size
   #   row :snapshot_updated_at
      row :update_flag
      row :logo_file_name
      row :logo_content_type
      row :logo_file_size
      row "Logo" do |non_profit| 
          link_to(image_tag(non_profit.logo.url(), :height => '100'))
      end 
    end  
   
  end

end
