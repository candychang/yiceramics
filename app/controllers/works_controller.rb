class WorksController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def index
      @works = Work.all
  end
  
  def show
      @work = Work.find_by_id(params[:id])
  end
  
  def edit
    @work = Work.find_by_id(params[:id])
  end
  
  def new
      @work = Work.new
  end

  def create
      @work = Work.create(work_params)
      if @work.save!
          redirect_to @work
      else
          //
      end
  end
  
  def update
      curr_work = Work.find_by_id(params[:id])
      if curr_work.update!(work_params)
          redirect_to curr_work
      else
          //
      end
  end
  
  private
    def work_params
      params.require(:work).permit(:name, :details, :size, :clay_type, :fire_type, :image, :remove_image)
    end
  
  
end
