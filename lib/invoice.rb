class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created,
              :updated,
              :repo

  def initialize(id,customer_id,merchant_id,status,created_at,updated_at, repo)
    @id          = id
    @customer_id = customer_id
    @merchant_id = merchant_id
    @status      = status
    @created     = created_at
    @updated     = updated_at
    @repo        = repo
  end


end
