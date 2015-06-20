require_relative '../lib/list_and_search_methods'
require_relative '../lib/invoice_item'
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
      InvoiceItem.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_quantity(quantity)
    instances.select do |instance|
      if instance.quantity == quantity
        return instance
      end
    end
  end

  def find_by_item_id(id)
    instances.select do |instance|
      if instance.item_id == id
        return instance
      end
    end
  end

  def find_all_by_item_id(id)
    total = []
    instances.select do |instance|
      if instance.item_id == id
        total << instance
      end
    end
  end


  def find_all_by_quantity(quantity)
    result = []
    instances.select do |instance|
      if instance.quantity == quantity
        result << instance
      end
    end
  end

  def find_an_invoice_by_invoice_id(instance)
    @sales_engine.find_an_invoice_by_invoice_id(instance)
  end

end
