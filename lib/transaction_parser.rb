require_relative '../lib/transactions'

class TransactionParser
  attr_reader :data
  def initialize(repo)
    @repo = repo
  end

  def convert(data)
    @data = data
    return Transactions.new(get_id,get_invoice_id,get_cc_num, get_cc_ex, get_result, get_created,get_updated, @repo)
  end

  def get_result
    data[:result]
  end

  def get_invoice_id
    data[:invoice_id]
  end

  def get_cc_ex
    data[:credit_card_expiration_date]
  end

  def get_cc_num
    data[:credit_card_number]
  end

  def get_id
    data[:id]
  end

  def get_created
    data[:created_at]
  end

  def get_updated
    data[:updated_at]
  end

end
