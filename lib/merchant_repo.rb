require './lib/list_and_search_methods'
class MerchantRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = []
  end
  def manage
    parser = MerchantParser.new(self)
    @instances = data.map do |line|
      parser.convert(line)
    end
  end
end