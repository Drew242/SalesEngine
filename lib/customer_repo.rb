require_relative '../lib/list_and_search_methods'
require_relative '../lib/customer'
require 'bigdecimal'
class CustomerRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    return data.map do |line|
      Customer.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_first_name(first_name)
    instances.detect do |instance|
      instance.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_first_name(first_name)
    instances.select do |instance|
      instance.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_by_last_name(last_name)
    instances.detect do |instance|
      instance.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_all_invoices_by_id(instance)
    @sales_engine.find_all_invoices_by_id(instance)
  end

end
