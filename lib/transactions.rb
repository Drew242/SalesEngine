
class Transactions
  attr_reader :id, :invoice_id, :cc_num, :cc_ex, :merchant_id, :created, :updated, :result
  def initialize(id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at, repo)
    @id          = id
    @invoice_id  = invoice_id
    @cc_num      = credit_card_number
    @cc_ex       = credit_card_expiration_date
    @merchant_id = merchant_id
    @created     = created_at
    @updated     = updated_at
    @result      = result
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Transaction #{id}"
  end
end
