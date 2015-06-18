require_relative '../lib/merchant'
require_relative '../lib/list_and_search_methods'
require_relative '../lib/sales_engine'

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

  def pass(instance)
    @sales_engine.take_merchant(instance)
  end

end
