class NonProfits::RegistrationsController < Devise::RegistrationsController
  
  def create
    logger = Logger.new('log/non_profit.log')
    logger.info('========= Log for nonprofit ============')
    build_resource()
    if resource.save
      sign_up(resource_name, resource)
      set_flash_message :notice, :non_profit_signup_success
      logger.info(current_non_profit.id)
      logger.info(new_payment_path)
      respond_with resource, :location => new_payment_path
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
 
  protected
  
  def build_resource(hash=nil)
    hash ||= resource_params || {}
    self.resource = resource_class.new_with_session(hash, session)
  end
  
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end
  
end
