class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to admin_dashboard_path
    end
  end
  
  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
      log_in(admin)
      redirect_to admin_dashboard_path
    else
      flash.now[:error] = "Invalid email/password combination"
      render "new"
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
