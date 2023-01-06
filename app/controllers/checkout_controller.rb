class CheckoutController < ApplicationController
    
    def clear
        @cart = CartItem.find(session[:cart])
        @cart.each do |c|
            c.destroy
        end
        session[:cart] = []
    end

    def create
        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            line_items: @cart.collect { |item| item.to_builder.attributes! },
            mode: 'payment',
            success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_url,
        })
        redirect_to(@session.url, allow_other_host: true)
    end

    def success
        if params[:session_id].present? 
            clear
            @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})
            @session_with_expand.line_items.data.each do |line_item|
                product = Product.find_by(stripe_product_id: line_item.price.product)
            end
        else
            redirect_to cancel_url, alert: "No info to display"
        end
    end
    
    def cancel
    end

end