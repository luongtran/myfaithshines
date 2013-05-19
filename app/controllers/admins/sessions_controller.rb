class Admins::SessionsController < Devise::SessionsController
  # DELETE /resource/sign_out
  def destroy
    if !current_user.nil?
       Reservation.destroy_all(["user_id = ?", current_user.id])
    end
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        head :no_content
      end
    end
  end

  def new
    self.resource = build_resource(nil, :unsafe => true)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end
  
   # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if params[:getstarted].nil?
      if params[:findmydog].nil?
        respond_with resource, :location => after_sign_in_path_for(resource)
      else
        respond_with resource, :location => find_my_block_path
      end
      
    else
      respond_with resource, :location => getstarted_path
    end
  end
end