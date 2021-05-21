module UsersHelper

  def search_orders(item)
    @order = Order.where(item_id: item.id)
    return @order
  end

  def search_sold_item(order)
    item = Item.find(order.item_id)
    return item
  end

  def search_item(oi)
    @item = Item.find(oi.item_id)
    return @item
  end


end