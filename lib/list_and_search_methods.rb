module ListSearch
  def all()
    instances
  end

  def random()
    instances.shuffle.first
  end

  def find_by_id(id)
    instances.select do |instance|
      if instance.id.downcase.include?(id.downcase)
        return instance
      end
    end
  end

  def find_by_name(name)
    instances.select do |instance|
      if instance.name.downcase.include?(name.downcase)
        return instance
      end
    end
  end


  def find_all_by_name(name)
    result =[]
    instances.select do |instance|
      if instance.name.downcase.include?(name.downcase)
        result << instance
      end
    end
    return result
  end


  def find_by_created_at(date)
    instances.select do |instance|
      if instance.created.downcase.include?(date.downcase)
        return instance
      end
    end
  end

  def find_by_updated_at(date)
    instances.select do |instance|
      if instance.updated.downcase.include?(date.downcase)
        return instance
      end
    end
  end

  def find_all_by_id(id)
    result =[]
    instances.select do |instance|
      if instance.id.downcase.include?(id.downcase)
        result << instance
      end
    end
    return result
  end

  def find_all_by_created_at(created_at)

    result =[]
    instances.select do |instance|
      if instance.created.downcase.include?(created_at.downcase)
        result << instance
      end
    end
    return result
  end

  def find_all_by_updated_at(updated_at)
    result =[]
    instances.select do |instance|
      if instance.updated.downcase.include?(updated_at.downcase)
        result << instance
      end
    end
    return result
  end

  def find_all_by_unit_price(price)
    result =[]
    instances.select do |instance|
      if instance.price.include?(price)
        result << instance
      end
    end
    return result
  end

  def find_by_merchant_id(id)
    instances.select do |instance|
      if instance.merchant_id.downcase.include?(id.downcase)
        return instance
      end
    end
  end

  def find_by_customer_id(id)
    instances.select do |instance|
      if instance.customer_id.downcase.include?(id.downcase)
        return instance
      end
    end
  end

  def find_by_unit_price(price)
    instances.select do |instance|
      if instance.price.include?(price)
        return instance
      end
    end
  end

end
