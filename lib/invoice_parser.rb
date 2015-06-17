require_relative '../lib/invoice'
class InvoiceParser
  attr_reader :data
  def initialize(repo)
    @repo = repo
  end

  def convert(data)
    @data = data
    return Invoice.new(get_id,get_customer_id,get_merchant_id,get_status,get_created,get_updated, @repo)
  end

  def get_customer_id
    data[:customer_id]
  end

  def get_merchant_id
    data[:merchant_id]
  end

  def get_status
    data[:status]
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
