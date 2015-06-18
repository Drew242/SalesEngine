require_relative '../lib/merchant'
require_relative '../lib/list_and_search_methods'
require_relative '../lib/sales_engine'
require 'bigdecimal'

class MerchantRepository < SalesEngine
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

  def find_all_items_by_merchant_id(instance)
    @sales_engine.find_all_items_by_merchant_id(instance)
  end

  def find_all_invoices_by_merchant_id(instance)
    @sales_engine.find_all_invoices_by_merchant_id(instance)
  end

end
