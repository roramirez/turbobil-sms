class RegistrationsController < Devise::RegistrationsController
  layout "blank"


  protected
  def after_sign_up_path_for(resource)
    new_customer_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_customer_session_path
  end

  protected
  def build_resource(hash=nil)
    super
    #init value new customer
    self.resource.type_pay = 1
    self.resource.admin = Admin.first
    self.resource.credit = 0
    self.resource
  end

  private
  def sign_up_params
    params.require(:customer).permit(:email, :name, :password, :password_confirmation)
  end
end
