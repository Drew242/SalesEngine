
class MerchantRepository
  attr_reader :data, :sales_engine, :instances
  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances = []
  end

  def manage
    parser = MerchantParser.new(self)
    @instances = data.map do |line|
      parser.convert(line)
    end
  end

  def all()
    instances
  end

  def random()
    instances.shuffle.first
  end

  def find_by_first_name(first_name)

    instances.each do |instance|
      if instance.name.include?(first_name)
        return  instance
      end
    end
    
  end

  def find_by_id(id)

    instances.each do |instance|
      if instance.id.include?(id)
        return instance
      end
    end

  end

  def find_by_created_at(date)
    matches = []
    instances.each do |instance|
      if instance.created.include?(date)
        return instance
      end
    end

  end

  def find_by_updated_at(date)

    instances.each do |instance|
      if instance.updated.include?(date)
        return instance
      end
    end
  end


end
