class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :price, :created, :updated

  def initialize(id,item_id,invoice_id,quantity,unit_price,created_at,updated_at, repo)
    @id          = id
    @item_id     = item_id
    @invoice_id  = invoice_id
    @quantity    = quantity
    @price       = unit_price
    @created     = created_at
    @updated     = updated_at
    @repo        = repo
  end


end
