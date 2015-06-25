require 'bigdecimal'
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
    instances.detect do |instance|
      instance.description.downcase.include?(description.downcase)
    end
  end

  def find_invoice_items_by_item_id(instance)
    @sales_engine.find_invoice_items_by_item_id(instance)
  end

  def find_merchant_by_merchant_id(instance)
    @sales_engine.find_merchant_by_merchant_id(instance)
  end

  def find_all_by_item_id(id)
    instances.select do |instance|
      instance.item_id == id
    end
  end


  def most_revenue(num_of_items)
    return all.max(num_of_items) do |a, b|
      revenue(a) <=> revenue(b)
    end
  end

  def revenue(item)
    ii = get_invoice_items(item)
    revenue = 0
    ii.compact.each do |invoice_item|
      revenue += (invoice_item.price * invoice_item.quantity)
    end
    revenue
  end

  def get_invoice_items(item)
    invoice_items_array ||= item.invoice_items
    return invoice_items_array.map do |invoice_item|
      invoice_item.invoice.transactions.map do |transaction|
        if transaction.result == "success"
          invoice_item
        end
      end
    end.flatten
  end

  def most_items(num_of_top_items)
    return  all.max_by(num_of_top_items) do |item|
      find_quantity(item)
    end
  end

  def find_quantity(item)
    total = get_invoice_items(item)
    quantities = total.compact.map do |invoice_item|
      if invoice_item
        invoice_item.quantity
      end
    end
    if quantities.reduce(:+)
      return quantities.reduce(:+)
    else
      0
    end
  end

end
