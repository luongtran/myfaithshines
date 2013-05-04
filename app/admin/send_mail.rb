ActiveAdmin.register_page "Send Mail" do
  
  menu :label => "Send Mail"
  menu :parent => "Mails", :parent_priority => 9

    content do
      @email = params[:addresses]
	    render :partial=>"index", :locals => {:addresses => @email} 
	  end
  end