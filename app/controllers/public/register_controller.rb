class Public::RegisterController < ApplicationController
  def index
    @invite = Invite.find_valid_invite(params[:token])
    if @invite.nil?
      redirect_to "/"
    end
  end
end
