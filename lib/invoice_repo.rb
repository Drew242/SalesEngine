require_relative '../lib/list_and_search_methods'
require_relative '../lib/invoice_parser'
class InvoiceRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = manage
  end
  def manage
    parser = InvoiceParser.new(self)
    return data.map do |line|
      parser.convert(line)
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
