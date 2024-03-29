class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.has_role? :admin
        redirect_to admin_path
      else
        redirect_to cryptocurrencies_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end
