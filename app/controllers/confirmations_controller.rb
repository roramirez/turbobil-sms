class ConfirmationsController < Devise::ConfirmationsController
  layout "blank"

  protected

  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      new_list_path
    else
      sign_in(resource)
      if signed_in?(resource_name)
        new_list_path
      else
        new_customer_session_path
      end
    end
  end
end
