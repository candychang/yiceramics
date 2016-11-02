class CartSession
    def initialize(session)
        @session = session
        @session[:cart] ||= {}
    end

    #Cart Count
    def cart_count
        if (@session[:cart] && @session[:cart] != {})
            @session[:cart].item_count
        else
            0
        end
    end
end
