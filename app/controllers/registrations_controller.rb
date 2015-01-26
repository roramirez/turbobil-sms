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
    admin = Admin.first
    self.resource.type_pay = 1
    self.resource.admin = admin
    self.resource.price_customer_id = admin.default_price_customer_id
    self.resource.credit = 0
    self.resource
  end

  private
  def sign_up_params
    params.require(:customer).permit(:email, :name, :password, :password_confirmation, :language)
  end
end
