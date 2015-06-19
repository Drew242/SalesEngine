require 'bigdecimal'
class Item

  attr_reader :id,
              :name,
              :description,
              :price,
              :merchant_id,
              :created,
              :updated
  def initialize(data, repo)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @price       = data[:unit_price]
    @merchant_id = data[:merchant_id].to_i
    @created     = data[:created_at]
    @updated     = data[:updated_at]
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Item #{id}"
  end

  def invoice_items
    @repo.find_invoice_items_by_item_id(id)
  end

  def merchant
    @repo.find_merchant_by_merchant_id(merchant_id)
  end

end