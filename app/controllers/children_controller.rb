class ChildrenController < ApplicationController
  before_action :authenticate_user!
  def index
    @current_user = current_user
    @children = @current_user.children.order(created_at: :desc).page(params[:page]).per(6)
  end
end
