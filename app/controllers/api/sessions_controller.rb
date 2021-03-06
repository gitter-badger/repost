class Api::SessionsController < Api::ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    current_user = login(params[:email], params[:password])

    if current_user
      current_user.create_token
    else
      render status: :bad_request, json: { errors: ['Email or password is incorrect.'] }
    end
  end

  def destroy
    current_user.delete_token
    head :ok
  end
end
