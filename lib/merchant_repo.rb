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
    items = @instances.map do |merchant|
      find_all_items_by_merchant_id(merchant.id)
    end
    items.sort! do |a, b|
      b.length <=> a.length
    end
    merchants = items.take(num_of_top_merchants).map do |item|
      find_by_id(item[0].merchant_id)
    end
  end

end
