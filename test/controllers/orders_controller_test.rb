require 'test_helper'
class OrdersControllerTest < ActionController::TestCase
    test "requires item in cart" do
        get :new
        assert_redirected_to root_path
        assert_equal flash[:notice], 'Your cart is empty'
    end

    test "should get new" do
        item = LineItem.new
        item.build_cart
        item.product = products(:ruby)
        item.save!
        session[:cart_id] = item.cart.id
        get :new
        assert_response :success
    end

    test "should create order" do
        assert_difference('Order.count') do
          post :create, order: { address: @order.address, email: @order.email,
            name: @order.name, pay_type: @order.pay_type }
        end
        assert_redirected_to root_path
    end
end
