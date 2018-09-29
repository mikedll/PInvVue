class PurchaseOrdersController < ApplicationController

  def index
    @collection = PurchaseOrder.with_customer.search(search_params)
    render :template => 'shared/standard'
  end

  def show
    @record = PurchaseOrder.with_customer.with_line_items.find(params[:id]).as_json(include: [:customer, {line_items: {include: :item} }])
  end

  protected

  def search_params
    params.permit(:t, :mt, :page)
  end
end
