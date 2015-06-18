require_relative '../lib/merchant_repo'

class Merchant
  attr_reader :id, :name, :created, :updated
  def initialize(data, repo)
    @id      = data[:id]
    @name    = data[:name]
    @created = data[:created_at]
    @updated = data[:updated_at]
    @repo    = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Merchant #{id}"
  end

  def items
    @repo.pass(id)
  end

end
