require_relative '../lib/list_and_search_methods'
require_relative '../lib/item'
require 'bigdecimal'

class ItemsRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances

  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    return data.map do |line|
      Item.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_description(description)
    instances.select do |instance|
      if instance.description.downcase.include?(description.downcase)
        return instance
      end
    end
    return nil
  end

  def find_invoice_items_by_invoice_id(instance)
    @sales_engine.find_invoice_items_by_invoice_id(instance)
  end

  def find_merchant_by_merchant_id(instance)
    @sales_engine.find_merchant_by_merchant_id(instance)
  end


end
