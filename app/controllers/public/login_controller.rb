class Public::LoginController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to "/admin" if @current_user
  end
end

