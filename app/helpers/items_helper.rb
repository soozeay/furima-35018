module ItemsHelper

  def choice_amount_for_cart(item_stock)
    item_stock_array = []
    item_stock.times do |i|
      item_stock_array << i + 1
    end
    item_stock_array
  end
end
