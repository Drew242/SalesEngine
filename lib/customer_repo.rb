require_relative '../lib/list_and_search_methods'
require_relative '../lib/customer_parser'
class CustomerRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    parser = CustomerParser.new(self)
    return data.map do |line|
      parser.convert(line)
    end
  end

  def find_by_first_name(first_name)
    instances.select do |instance|
      if instance.first_name.downcase.include?(first_name.downcase)
        return instance
      end
    end
  end

  def find_by_last_name(last_name)
    instances.select do |instance|
      if instance.last_name.downcase.include?(last_name.downcase)
        return instance
      end
    end
  end

end
