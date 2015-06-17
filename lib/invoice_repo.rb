require './lib/list_and_search_methods'
class InvoiceRepository
  include ListSearch
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = []
  end
  def manage
    parser = InvoiceParser.new(self)
    @instances = data.map do |line|
      parser.convert(line)
    end
  end

  def find_by_status(status)
    instances.each do |instance|
      if instance.status.include?(status)
        return instance
      end
    end
  end
end
