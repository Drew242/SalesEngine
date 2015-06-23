require_relative '../lib/merchant'
require_relative '../lib/list_and_search_methods'
require_relative '../lib/sales_engine'
require 'bigdecimal'

class MerchantRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    return data.map do |line|
      Merchant.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_all_items_by_merchant_id(instance)
    @sales_engine.find_all_items_by_merchant_id(instance)
  end

  def find_all_invoices_by_merchant_id(instance)
    @sales_engine.find_all_invoices_by_merchant_id(instance)
  end

  def most_items(num_of_top_merchants)
    return  all.max(num_of_top_merchants) do |merchant, merchant2|
      find_quantity(merchant) <=> find_quantity(merchant2)
    end
  end

  def find_quantity(merchant)
    invoices = merchant.invoices
    total = invoices.map do |invoice|
      invoice.transactions.map do |transaction|
        if transaction.result == "success"
          ii = invoice.invoice_items
        end
      end
    end.flatten
    quantities = total.compact.map do |invoice_item|
      invoice_item.quantity
    end
    quantities.reduce(:+)

  end


  def most_revenue(num_of_top_merchants)
    return all.max(num_of_top_merchants) do |a, b|
      a.revenue <=> b.revenue
    end
  end

  def revenue(date)
    return all.reduce(0) do |result, merchant|
       result += merchant.revenue(date)
       result
    end
  end


end
