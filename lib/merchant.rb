require_relative '../lib/merchant_repo'
require 'bigdecimal'

class Merchant
  attr_reader :id, :name, :created, :updated
  def initialize(data, repo)
    @id      = data[:id].to_i
    @name    = data[:name]
    @created = Date.parse(data[:created_at])
    @updated = Date.parse(data[:updated_at])
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

  def revenue(date = nil)
    ii = get_invoice_items(date)
    revenue = 0
    ii.compact.each do |invoice_item|
      revenue += (invoice_item.price * invoice_item.quantity)
    end
    revenue
  end

  def parse_date(date)
    return invoices.select do |invoice|
      if date.nil?
        invoice
      else
        invoice.created.strftime("%Y-%m-%d") == date.strftime("%Y-%m-%d")
        require 'pry'
        binding.pry
      end
    end
  end

  def get_invoice_items(date)
    invoices_array = parse_date(date)
    return invoices_array.map do |invoice|
      invoice.transactions.map do |transaction|
        if transaction.result == "success"
          invoice.invoice_items
        end
      end
    end.flatten
  end

end
