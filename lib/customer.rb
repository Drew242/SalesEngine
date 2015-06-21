require 'bigdecimal'
class Customer
  attr_reader :id, :first_name, :last_name, :created, :updated
  def initialize(data, repo)
    @id          = data[:id].to_i
    @first_name  = data[:first_name]
    @last_name   = data[:last_name]
    @created     = data[:created_at]
    @updated     = data[:updated_at]
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Customer #{id}"
  end

  def invoices
    @repo.find_all_invoices_by_id(id)
  end

end
