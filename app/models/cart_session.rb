class CartSession
    def initialize(session)
        @session = session
        @session[:cart] ||= Cart.create.id
    end

    def cart
        if (@session[:cart] && @session[:cart] != {})
            return Cart.find_by_id(@session[:cart])
        else
            cart = Cart.create
            @session[:cart] = cart.id
            return cart
        end
    end
            
end
