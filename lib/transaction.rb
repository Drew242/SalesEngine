
class Transaction
  attr_reader :id,
              :invoice_id,
              :cc_num,
              :cc_ex,
              :merchant_id,
              :created,
              :updated,
              :result

  def initialize(data, repo)
    @id          = data[:id]
    @invoice_id  = data[:invoice_id]
    @cc_num      = data[:credit_card_number]
    @cc_ex       = data[:credit_card_expiration_date]
    @merchant_id = data[:merchant_id]
    @created     = data[:created_at]
    @updated     = data[:updated_at]
    @result      = data[:result]
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Transaction #{id}"
  end
end
