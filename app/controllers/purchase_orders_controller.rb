class PurchaseOrdersController < ApplicationController
  def index
    pos = PurchaseOrder.search(params)[:results]
    render :inline => "POs: " + pos.map { |po| po['id'] }.join(',')
  end
end
