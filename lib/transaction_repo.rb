require_relative '../lib/list_and_search_methods'
require_relative '../lib/transaction'
require 'bigdecimal'

class TransactionRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances

  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end

  def manage
    return data.map do |line|
      Transaction.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_cc_num(num)
    instances.select do |instance|
      if instance.cc_num.include?(num)
        return instance
      end
    end
    return nil
  end

  def find_all_invoices_by_invoice_id(instance)
    @sales_engine.find_all_invoices_by_invoice_id(instance)
  end
end
