class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def search
    @items = Item.where("lower(name) LIKE ? OR lower(name) LIKE ?", "%#{params[:search].downcase.strip()}", "#{params[:search].downcase.strip}%")
    render 'items#edit': @items
  end

  def create
    @item = Item.new item_params
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def update
    @item = Item.find_by id: params[:id]
    if @item.update item_params
      redirect_to items_path
    else
      flash[:notice] = "Unable to proceed!"
      redirect_to items_path
    end
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find_by id: params[:id]
  end

  def destroy
    @item = Item.find_by id: params[:id]
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end

