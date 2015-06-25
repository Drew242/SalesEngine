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
      create_new_transaction(line)
    end
  end

  def create_new_transaction(line)
    Transaction.new(line, self)
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_credit_card_number(num)
    instances.detect do |instance|
      instance.cc_num.include?(num)
    end
  end

  def find_all_by_result(input)
    instances.select do |instance|
      instance.result == input
    end
  end

  def find_an_invoice_by_invoice_id(instance)
    @sales_engine.find_an_invoice_by_invoice_id(instance)
  end
end
