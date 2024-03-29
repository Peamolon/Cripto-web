class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @investments = Investment.includes(:user, :crypto, :wallet, :profits).all.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def verify_admin
    redirect_to root_path, alert: "You do not have access to this page" unless current_user.has_role? :admin
  end
end
