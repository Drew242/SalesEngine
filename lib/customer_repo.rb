require './lib/list_and_search_methods'
class CustomerRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = []
  end

  def manage
    parser = CustomerParser.new(self)
    @instances = data.map do |line|
      parser.convert(line)
    end
  end

  def find_by_first_name(first_name)

    instances.each do |instance|
      if instance.first_name.include?(first_name)
        return instance
      end
    end
  end
  def find_by_last_name(last_name)

    instances.each do |instance|
    if instance.last_name.include?(last_name)
        return instance
      end
    end
  end
  
  def find_all_by_first_name(first_name)
    result =[]
    instances.each do |instance|
      if instance.first_name.include?(first_name)
        result << instance
      end
    end
    return result

  end
end
