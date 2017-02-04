class WorksController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json, :only => [:index]
  
  def index
      @works = Work.all
      respond_with @works
  end
  
  def show
      @work = Work.find_by_id(params[:id])
  end
  
  
end
