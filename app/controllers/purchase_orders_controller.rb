class PurchaseOrdersController < ApplicationController
  def index
    pos = PurchaseOrder.with_customer.search(params)[:results]
    @collection = pos
    render :template => 'shared/collection'
  end
end
