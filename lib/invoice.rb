class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created,
              :updated,
              :repo

  def initialize(data, repo)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created     = data[:created_at]
    @updated     = data[:updated_at]
    @repo        = repo
  end

  def transactions
    @repo.find_all_transactions_by_invoice_id(id)
  end

  def invoice_items
    @repo.find_all_invoice_items_by_invoice_id(id)
  end

  def items
    @repo.find_all_items_by_invoice_id(id)
  end

  def customer
    @repo.find_a_customer_by_invoice_id(customer_id)
  end

  def merchant
    @repo.find_a_merchant_by_invoice_id(merchant_id)
  end

end
