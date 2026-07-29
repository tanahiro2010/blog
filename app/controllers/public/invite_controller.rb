class Public::InviteController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @token = params[:token]
    if @token.nil?
      redirect_to "/"
      return
    end

    @result = params[:result].nil? ? nil : params[:result]
    @message = params[:message].nil? ? nil : params[:message]
  end
end
