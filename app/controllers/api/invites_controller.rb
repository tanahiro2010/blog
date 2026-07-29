class Api::InvitesController < ApiApplicationController
  def show
    token = params[:id]
    invite = Invite.find_valid_invite(token)
    if invite.nil?
      render json: ApiApplicationHelper::Response.not_found(message: "Invalid or expired invite token", data: {
        token: token
      }), status: :not_found
      return
    end

    render json: ApiApplicationHelper::Response.ok(message: "#{id} hello")
  end

  def create
    email = params[:email]

    begin
      invite = Invite.create_invite(email)

      result = InviteMailer.with(invite).invite_email
      if result.is_a?(Net::HTTPOK)
        if @is_json
          res = ApiApplicationHelper::Response.success(message: "Invite email sent successfully")
          render json: res
        else
          redirect_to "/invite?result=created&message=#{CGI.escape("Invite email sent successfully")}"
        end
      else
        if @is_json
          res = ApiApplicationHelper::Response.error(message: "Failed to send invite email")
          render json: res, status: :internal_server_error
        else
          redirect_to "/invite?result=failed&message=#{CGI.escape("Failed to send invite email")}"
        end
      end
    rescue Error => e
      render json: ApiApplicationHelper::Response.error(message: "Failed to create invite", data: {
        error: e.message
      }), status: :internal_server_error
    end
  end
end
