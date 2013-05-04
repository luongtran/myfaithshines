module ApplicationHelper
  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
  
  def flash_message
    messages =""
    [:notice, :info, :warning, :error, :alert].each {|type|
      if flash[type] && flash[type] != 'You need to sign in or sign up before continuing.'
         messages += "<p class=\"#{type}\">#{flash[type]}</p>"
      end
    }
    
    messages.html_safe
  end
end
