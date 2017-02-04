class AdminsController < ApplicationController
    before_action :authenticate_user
    
    def dashboard
        @admin = current_admin
    end
end
