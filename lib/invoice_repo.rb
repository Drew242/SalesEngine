require_relative '../lib/list_and_search_methods'
require_relative '../lib/invoice'
require 'bigdecimal'
class InvoiceRepository
  include ListSearch

  attr_reader :data, :sales_engine, :instances

  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    return data.map do |line|
      Invoice.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_status(status)
    instances.select do |instance|
      if instance.status.downcase.include?(status.downcase)
        return instance
      end
    end
    return nil
  end

  def find_all_by_status(status)
    total = []
    instances.select do |instance|
      if instance.status.downcase.include?(status.downcase)
        total << instance
      end
    end
    return total
  end

  def find_by_customer_id(id)
    instances.select do |instance|
      if instance.customer_id == id
        return instance
      end
    end
    return nil
  end

  def find_all_by_customer_id(id)
    invoices = []
    instances.select do |instance|
      if instance.customer_id == id
        invoices << instance
      end
    end
    invoices
  end

  def find_all_invoice_items_by_invoice_id(id)
    @sales_engine.find_all_invoice_items_by_invoice_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    @sales_engine.find_all_transactions_by_invoice_id(id)
  end

  def find_all_items_by_invoice_id(id)
    @sales_engine.find_all_items_by_invoice_id(id)
  end

  def find_a_customer_by_invoice_id(id)
    @sales_engine.find_a_customer_by_invoice_id(id)
  end

  def find_a_merchant_by_invoice_id(id)
    @sales_engine.find_a_merchant_by_invoice_id(id)
  end

end
