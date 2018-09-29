class ItemsController < ApplicationController

  MAX_AUTOCOMPLETE = 30 # otherwise jqueryUI can't handle it

  def autocomplete
    @items = Item.by_name(params[:term]).limit(MAX_AUTOCOMPLETE)
    render json: @items.map { |i| {:value => i.as_json, :label => "#{i.name} ($#{i.unit_price})"} }
  end

  protected

end
