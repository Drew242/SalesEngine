
class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :price,
              :created,
              :updated

  def initialize(data, repo)
    @id          = data[:id].to_i
    @item_id     = data[:item_id].to_i
    @invoice_id  = data[:invoice_id].to_i
    @quantity    = data[:quantity].to_i
    @price       = data[:unit_price]
    @created     = data[:created_at]
    @updated     = data[:updated_at]
    @repo        = repo
  end


end
