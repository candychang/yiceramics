class CartSessionsController < ApplicationController

    def cart_session
      @cart_session ||= CartSession.new(session)
    end
    helper_method :cart_session
end
