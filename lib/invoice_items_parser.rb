require_relative '../lib/invoice_item'
class InvoiceItemsParser
  attr_reader :data

  def initialize(repo)
    @repo = repo
  end

  def convert(data)
    @data = data
    return InvoiceItem.new(get_id,get_item_id,get_invoice_id,get_quantity,get_price,get_created,get_updated, @repo)
  end

  def get_item_id
    data[:item_id]
  end

  def get_invoice_id
    data[:invoice_id]
  end

  def get_quantity
    data[:quantity]
  end
  def get_id
    data[:id]
  end

 def get_price
   data[:unit_price]
 end

  def get_created
    data[:created_at]
  end

  def get_updated
    data[:updated_at]
  end

end
