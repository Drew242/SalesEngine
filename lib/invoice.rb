class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created,
              :updated,
              :repo

  def initialize(data, repo)
    @id          = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status      = data[:status]
    @created     = data[:created_at]
    @updated     = data[:updated_at]
    @repo        = repo
  end


end
