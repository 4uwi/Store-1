class OrdersController < ApplicationController

  def index
    @orders = Order.where(:user_id => [current_user.id]).all
  end

  def show
    @order = Order.find_by id: params[:id]
    @order_description = OrderDescription.find_by order_id: @order.id
    @item = Item.find_by id: @order_description.item_id
  end

  def new
    @item = Item.find_by id: params[:format]
  end

  def create
    @order = Order.new
    if @order.update order_params
      @order_d = OrderDescription.new

      if @order_d.update order_d_params and @order_d.update order_id: @order.id
        redirect_to orders_path
      end
    else
      falsh[:notice] = "Can`t proceed the order"
      redirect_to items_path
    end
  end

  private

  def order_params
    return {amount: params[:amount], user_id: current_user.id}
  end

  def order_d_params
    params.require(:order_description).permit(:item_id, :quantity)
  end
end