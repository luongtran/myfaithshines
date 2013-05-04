ActiveAdmin.register MailMessage do
 
  menu :label => "Sent Mail", :priority => 0, :parent => "Mails", :parent_priority => 9, :parent_link => :self
  
  actions :all, :except => [:edit, :destroy, :new]
  config.comments = false
  controller do
      # This code is evaluated within the controller class

      def send_messages           
        mail_list = []             
        mail = MailMessage.new
        
        if !(params[:all_users].nil?)         
          mail.all_users = true
          all_users = User.all         
          all_users.each do |user|
            if !(user.email.nil?)
              mail_list << user.email
            end  
          end
        end
        if !(params[:all_sponsors].nil?)   
          mail.all_sponsors = true      
          all_sponsors = Sponsor.all
          all_sponsors.each do |sp|
            if !(sp.email.nil?)
              mail_list << sp.email
            end
          end    
        end
        if !(params[:all_nonprofits].nil?)
          mail.all_nonprofits = true
          all_profits = NonProfit.all
          all_profits.each do |prof|
            if !(prof.email.nil?) 
                mail_list << prof.email
            end 
          end  
        end
        if !(params[:others_mail].nil?)
          mail.other_mails = params[:others_mail]
          other_params = params[:others_mail].split(',')
          other_params.each do |mail|
            mail_list << mail
          end        
        end
        
        mail.addresses = mail_list.join(',')      
        mail.subject = params[:subject]
        mail.body = params[:body]
        mail.cc = params[:cc]
        mail.bcc = params[:bcc]
        
        mail.save

        mail_list.each do |recipient|
          UserMailer.send_mail(mail, recipient).deliver
        end

        
        
        redirect_to admin_mail_message_path(mail.id)
        
      end
      
      def compose_email
       
       
      end
    
    end 
    
    index do      
      column :id     
      column :subject
      column :body do |mail_message|
        div mail_message.body.nil? ? '' : mail_message.body.html_safe
      end
     
      column :created_at      
      column :links do |mail_messages|
        links = ''.html_safe
        if controller.action_methods.include?('show') 
          links += link_to I18n.t('active_admin.view'), resource_path(mail_messages), :class => "member_link view_link"
        end
        links
      end   
       
    end
    
    show do |mail_message|
     attributes_table do
        row :id
        row :subject
        row :created_at
        row :addresses
        row :other_mails
        row :cc
        row :bcc
        row ("Body") { mail_message.body.html_safe }   
      end
  end

end
