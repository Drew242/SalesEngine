class Customer
  attr_reader :id, :first_name, :last_name, :created, :updated
  def initialize(id,first_name,last_name,created_at,updated_at, repo)
    @id          = id
    @first_name  = first_name
    @last_name   = last_name
    @created     = created_at
    @updated     = updated_at
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Merchant #{id}"
  end
end