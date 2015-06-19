require_relative '../lib/merchant_repo'
require 'bigdecimal'

class Merchant
  attr_reader :id, :name, :created, :updated
  def initialize(data, repo)
    @id      = data[:id].to_i
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
    @items ||= @repo.find_all_items_by_merchant_id(id)
  end

  def invoices
    @invoices ||= @repo.find_all_invoices_by_merchant_id(id)
  end

  # ||= ensures that you only call the method once if needed

end
