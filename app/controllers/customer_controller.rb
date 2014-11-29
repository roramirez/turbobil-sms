class CustomerController < ApplicationController
  layout "customer"

  before_filter :authenticate_customer!

  def profile
    @user = current_customer
  end

  def update_profile
    @user = current_customer

    params_to_update = profile_params.dup
    if params_to_update[:password].blank?
      params_to_update.delete(:password)
      params_to_update.delete(:password_confirmation)
    end

    if @user.update_attributes(params_to_update)
      flash[:notice] = "Successfully updated your profile."
      redirect_to :action => 'profile'
    else
      flash[:error] = "Dont update profile."
      render :profile
    end
  end

  def smss
    @smss = smss_filtered
    @smss = @smss.page(params[:page]).per(10)
  end

  def smss_filtered
    @smss = current_customer.smss

    if params[:sms_start].blank? and  params[:sms_end].blank?
      params[:sms_start] =  DateTime.now.beginning_of_day.strftime('%Y/%m/%d %H:%M:%S')
      params[:sms_end] = DateTime.now.end_of_day.strftime('%Y/%m/%d %H:%M:%S')
    end

    @smss = @smss.sorted(params[:sort]).filter(params.slice(:ip, :sms_start, :sms_end))
  end

  def prices
    @prices_customer = PriceCustomer.get_join_route(current_customer.price_customer_id)
                                    .page(params[:page])
                                    .sorted(params[:sort])
                                    .per(10)
  end

  def dashboard
    @min = current_customer.minutes_sms_last_days.sort
    @minutes = []
    @min.each do |m|
      @minutes.append({date: m[0], minutes: m[1]})
    end
  end

  private
  def profile_params
    params.require(:customer).permit(:name, :email, :password)
  end


end
