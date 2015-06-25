require_relative '../lib/list_and_search_methods'
require_relative '../lib/invoice_item'
require 'bigdecimal'
class InvoiceItemsRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    return data.map do |line|
      create_new_item_invoice(line)
    end
  end

  def create_new_item_invoice(line)
    InvoiceItem.new(line, self)
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_quantity(quantity)
    instances.detect do |instance|
      instance.quantity == quantity
    end
  end

  def find_by_item_id(id)
    instances.detect do |instance|
      instance.item_id == id
    end
  end

  def find_all_by_item_id(id)
    instances.select do |instance|
       instance.item_id == id
    end
  end


  def find_all_by_quantity(quantity)
    instances.select do |instance|
      instance.quantity == quantity
    end
  end

  def find_an_invoice_by_invoice_id(instance)
    @sales_engine.find_an_invoice_by_invoice_id(instance)
  end

  def find_an_item_by_item_id(instance)
    @sales_engine.find_an_item_by_item_id(instance)
  end

end
