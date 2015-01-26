class PagesController < ApplicationController

  layout "site"

  def home
  end

  def about
  end

  def change_language
    if params[:set_locale]
      session[:locale] = params[:set_locale]
    end
    redirect_to pages_home_path
  end
end
