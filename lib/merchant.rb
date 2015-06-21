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

  def revenue
    ii = invoices.map do |invoice|
      invoice.transactions.map do |transaction|
        if transaction.result == "success"
          invoice.invoice_items
        end
      end
    end.flatten
    revenue = 0
    ii.compact.each do |invoice_item|
        revenue += (invoice_item.price * invoice_item.quantity)
    end
    revenue
  end

end
