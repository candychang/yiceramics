class WorksController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json, :only => [:index]
  
  def index
      @works = Work.all
      
      serious_list = []
      playful_list = []
      @works.each do |work|
        curr_work = {
          title: work.name,
          alt: work.name,
          thumbUrl: work.image.gallery.url,
          url: work.image.url
        }
        
        if work.playful
          playful_list << curr_work
        else
          serious_list << curr_work
        end
      end
      
      result = { serious: serious_list, playful: playful_list }.to_json
      respond_with result
  end
  
  def show
      @work = Work.find_by_id(params[:id])
  end
  
  
end
