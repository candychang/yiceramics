class AdminsController < ApplicationController
    before_action :authenticate_user
    
    def dashboard
        @admin = current_admin
    end
    
    private
    
    def authenticate_user
        unless logged_in?
            flash[:error] = "Must be logged in to see this page"
            redirect_to login_path
        end
    end
end
