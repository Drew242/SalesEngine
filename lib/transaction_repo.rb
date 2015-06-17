require_relative '../lib/list_and_search_methods'
require_relative '../lib/transaction_parser'
class TransactionRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = []
  end
  def manage
    parser = TransactionParser.new(self)
    @instances = data.map do |line|
      parser.convert(line)
    end
  end

  def find_by_cc_num(num)
    instances.select do |instance|
      if instance.cc_num.include?(num)
        return instance
      end
    end
  end
end
