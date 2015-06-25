require 'bigdecimal'
module ListSearch
  def all
    instances
  end

  def random
    instances.sample
  end

  def find_by_id(id)
    instances.select do |instance|
      if instance.id == id
        return instance
      end
    end
    return nil
  end

  def find_by_name(name)
    instances.detect do |instance|
      instance.name.downcase == name.downcase
    end
  end


  def find_all_by_name(name)
    instances.select do |instance|
      instance.name.downcase == name.downcase
    end
  end


  def find_by_created_at(date)
    instances.detect do |instance|
      instance.created == Date.parse(date)
    end
  end

  def find_by_updated_at(date)
    instances.detect do |instance|
      instance.updated == Date.parse(date)
    end
  end

  def find_all_by_id(id)
    instances.select do |instance|
      instance.id == id
    end
  end

  def find_all_by_created_at(created_at)
    instances.select do |instance|
      instance.created == Date.parse(created_at)
    end
  end

  def find_all_by_updated_at(updated_at)
    instances.select do |instance|
      instance.updated == Date.parse(updated_at)
    end
  end

  def find_all_by_unit_price(price)
    instances.select do |instance|
      instance.price == price
    end
  end

  def find_by_merchant_id(id)
    instances.detect do |instance|
    instance.merchant_id == id
    end
  end

  def find_all_by_merchant_id(id)
    instances.select do |instance|
      instance.merchant_id == id
    end
  end


  def find_by_invoice_id(id)
    instances.detect do |instance|
      instance.invoice_id == id
    end
  end

  def find_all_by_invoice_id(id)
    instances.select do |instance|
    instance.invoice_id == id
    end
  end

  def find_by_unit_price(price)
    instances.detect do |instance|
      instance.price == price
    end
  end

end
