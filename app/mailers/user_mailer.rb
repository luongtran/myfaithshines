class UserMailer < ActionMailer::Base
  default :from => "Good Dog Team <support@luckyheadfilms.com>"
  
=begin  def registration_confirmation(mail, user, transaction_id, price, numer_blocks, method)   
    email_list = mail.addresses.split(',') 
    @body = mail.body.html_safe
    
    email_list.each do |email|  
      if mail.body == "Receipt"
          if !mail.cc.nil? 
            mail(:to => email, :cc => mail.cc, :subject => "#{mail.subject}")do |format|
            format.html { render :partial => 'email_receipt.html.erb'}
          end
          end          
          if !mail.bcc.nil?
            mail(:to => email, :bcc => mail.bcc, :subject => "#{mail.subject}") do |format|
            format.html { render :partial => 'email_receipt.html.erb'}
            end
          end           
          
           mail(:to => email, :subject => "#{mail.subject}") do |format|
            format.html { render :partial => 'email_receipt.html.erb', :locals =>{:time => Time.now, :user => user, :transaction_id => transaction_id, :price => price, :numer_blocks => numer_blocks, :method => method}}
           end    
      end    
    end       
  end
=end 
 
 
  def send_mail(mail, recipient)
    @body = mail.body.html_safe

    mail(:to => recipient, :cc => mail.cc.nil? ? nil:mail.cc, :bcc=> mail.bcc.nil? ? nil : mail.bcc, :subject => "#{mail.subject}") do |format|
        format.html { render 'send_mail.html.erb'}
    end             
  end
 
  def registration_confirmation(mail, user, transaction_id, price, number_blocks, method)   
    email_list = mail.addresses.split(',') 
    @body = mail.body.html_safe
    
    email_list.each do |email|  
      if mail.body == "Receipt"
          if !mail.cc.nil? 
            mail(:to => email, :cc => mail.cc, :subject => "#{mail.subject}")do |format|
            format.html { render :partial => 'email_receipt.html.erb'}
          end
          end          
          if !mail.bcc.nil?
            mail(:to => email, :bcc => mail.bcc, :subject => "#{mail.subject}") do |format|
            format.html { render :partial => 'email_receipt.html.erb'}
            end
          end           
          
           mail(:to => email, :subject => "#{mail.subject}") do |format|
            format.html { render :partial => 'email_receipt.html.erb', :locals =>{:time => Time.now, :user => user, :transaction_id => transaction_id, :price => price, :number_blocks => number_blocks, :method => method}}
           end    
      end    
    end       
  end
  
  def registration_confirmation_deliverable(mail)   
    email_list = mail.addresses.split(',') 
    @body = mail.body.html_safe
    
    email_list.each do |email|  
      if !mail.attachments.nil?
          attachments['certificate.pdf'] = mail.attachments          
      end 
     
      if !mail.cc.nil? 
         mail(:to => email, :cc => mail.cc, :subject => "#{mail.subject}") do |format|
            format.html { render :partial => 'email_deliverable.html.erb' }
         end
      end 
      if !mail.bcc.nil?
          mail(:to => email, :bcc => mail.bcc, :subject => "#{mail.subject}")do |format|
            format.html { render :partial => 'email_deliverable.html.erb' }
         end
      end           
       mail(:to => email, :subject => "#{mail.subject}") do |format|
        format.html { render :partial => 'email_deliverable.html.erb' }
       end
   
   end     
  end
  
   
end
