class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate_user!
    before_action :initialize_session
    before_action :load_cart

    private

    def initialize_session
        session[:cart] ||= [] # empty cart = empty array
    end

    def load_cart
        @cart = Product.find(session[:cart])
    end
end
