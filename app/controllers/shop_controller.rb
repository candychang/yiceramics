class ShopController < ApplicationController
respond_to :json
    def index
        respond_with Work.all.as_json
    end
    
    def show
        respond_with Work.find_by_id(params[:id]).as_json
    end
        
end
