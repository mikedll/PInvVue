class LineItemsController < ApplicationController
  def destroy
    find_item
    @line_item.destroy
    render json: @parent
  end

  private

  def find_parent
    @parent = PurchaseOrder.find(params[:purchase_order_id])
  end

  def find_item
    find_parent
    @line_item = @parent.line_items.find(params[:id]) if params[:id]
  end
end
