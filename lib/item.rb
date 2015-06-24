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
    @price       = BigDecimal.new(data[:unit_price].insert(-3, "."))
    @merchant_id = data[:merchant_id].to_i
    @created     = Date.parse(data[:created_at])
    @updated     = Date.parse(data[:updated_at])
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

  def get_invoice_items
    invoice_items_array = invoice_items
    success =  invoice_items_array.map do |invoice_item|
      invoice_item.invoice.transactions.map do |transaction|
        if transaction.result == "success"
          invoice_item
        end
      end
    end.flatten
    success.compact
  end

  def best_day
    ii = get_invoice_items
    top =  ii.max do |a, b|
      get_revenue(a) <=> get_revenue(b)
    end
    top.invoice.created
  end

  def get_revenue(invoice_item)
    invoice_item.price * invoice_item.quantity
  end

end
