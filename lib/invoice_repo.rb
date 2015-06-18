require_relative '../lib/list_and_search_methods'
require_relative '../lib/invoice'
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

  def find_by_status(status)
    instances.select do |instance|
      if instance.status.downcase.include?(status.downcase)
        return instance
      end
    end
  end
end
