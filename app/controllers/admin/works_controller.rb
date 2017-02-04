class Admin::WorksController < ApplicationController
  before_action :authenticate_user
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
          redirect_to admin_work_path(@work)
      else
          flash[:error] = "Unable to create work"
          render :new
      end
  end
  
  def update
      curr_work = Work.find_by_id(params[:id])
      if curr_work.update!(work_params)
          redirect_to admin_work_path(curr_work)
      else
          flash[:error] = "Unable to create work"
          render :edit
      end
  end
  
  private
    def work_params
      params.require(:work).permit(:name, :details, :size, :clay_type, :fire_type, :shop_active, :gallery_active, :image, :remove_image)
    end
end
