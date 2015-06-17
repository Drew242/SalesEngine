require_relative '../lib/list_and_search_methods'
require_relative '../lib/invoice_items_parser'
class InvoiceItemsRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    parser = InvoiceItemsParser.new(self)
    return data.map do |line|
      parser.convert(line)
    end
  end

  def find_by_quantity(quantity)
    instances.select do |instance|
      if instance.quantity.include?(quantity)
        return instance
      end
    end
  end

  def find_by_invoice_id(id)
    instances.select do |instance|
      if instance.invoice_id == (id)
        return instance
      end
    end
  end

  def find_all_by_invoice_id(id)
    result = []
    instances.select do |instance|
      if instance.invoice_id == (id)
        result << instance
      end
    end
  end

  def find_all_by_quantity(quantity)
    result = []
    instances.select do |instance|
      if instance.quantity.include?(quantity)
        result << instance
      end
    end
  end
end
