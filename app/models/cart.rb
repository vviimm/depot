class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)

    if current_item
        current_item.quantity += 1
        current_price = current_item.product.price
        current_item.price = current_item.quantity * current_price
    else
        current_item = line_items.build(product_id: product_id)
        current_price = current_item.product.price
        current_item.price = current_price
    end
    current_item
  end

  def decrement_line_item_quantity(line_item_id)
    current_item = line_items.find(line_item_id)

    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.price }
  end
end
