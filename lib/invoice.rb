require 'bigdecimal'
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
    @created     = Date.parse(data[:created_at])
    @updated     = Date.parse(data[:updated_at])
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Invoice #{id}"
  end

  def transactions
    @transactions ||= @repo.find_all_transactions_by_invoice_id(id)
  end

  def invoice_items
    @invoice_items ||= @repo.find_all_invoice_items_by_invoice_id(id)
  end

  def items
    @items ||= @repo.find_all_items_by_invoice_id(id)
  end

  def customer
    @customer ||= @repo.find_a_customer_by_invoice_id(customer_id)
  end

  def merchant
    @merchant ||= @repo.find_a_merchant_by_merchant_id(merchant_id)
  end

  def reset_transactions
    @transactions = nil
  end

  def charge(card)
    reset_transactions
    credit_num        = card[:credit_card_number]
    credit_ex         = card[:credit_card_expiration]
    result            = card[:result]
    transaction_repo  = repo.sales_engine.transaction_repository
    id                = transaction_repo.instances.size + 1
    transaction       = create_transaction(credit_num, credit_ex, result, id)
    new_transaction   = transaction_repo.create_new_transaction(transaction)
    transaction_repo.instances << new_transaction
  end

  def create_transaction(credit_num, credit_ex, result, id)
    {id: id, invoice_id: self.id, credit_card_number: credit_num,
      credit_card_expiration: credit_ex,
      merchant_id: (self.merchant).id, created_at: Time.new.to_s,
      updated_at: Time.new.to_s, result: result}
  end

end
