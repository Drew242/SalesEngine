module ListSearch
  def all()
    instances
  end

  def random()
    instances.shuffle.first
  end

  def find_by_id(id)
    instances.select do |instance|
      if instance.id == id
        return instance
      end
    end
  end

  def find_by_name(name)
    instances.select do |instance|
      if instance.name.downcase == name.downcase
        return instance
      end
    end
  end


  def find_all_by_name(name)
    result =[]
    instances.select do |instance|
      if instance.name.downcase == name.downcase
        result << instance
      end
    end
    return result
  end


  def find_by_created_at(date)
    instances.select do |instance|
      if instance.created == date
        return instance
      end
    end
  end

  def find_by_updated_at(date)
    instances.select do |instance|
      if instance.updated == date
        return instance
      end
    end
  end

  def find_all_by_id(id)
    result =[]
    instances.select do |instance|
      if instance.id == id
        result << instance
      end
    end
    return result
  end

  def find_all_by_created_at(created_at)

    result =[]
    instances.select do |instance|
      if instance.created == created_at
        result << instance
      end
    end
    return result
  end

  def find_all_by_updated_at(updated_at)
    result =[]
    instances.select do |instance|
      if instance.updated == updated_at
        result << instance
      end
    end
    return result
  end

  def find_all_by_unit_price(price)
    result =[]
    instances.select do |instance|
      if instance.price == price
        result << instance
      end
    end
    return result
  end

  def find_by_merchant_id(id)
    instances.select do |instance|
      if instance.merchant_id == id
        return instance
      end
    end
  end

  def find_all_by_merchant_id(id)
    result =[]
    instances.select do |instance|
      if instance.merchant_id == id
        result << instance
      end
    end
    return result
  end

  def find_by_customer_id(id)
    instances.select do |instance|
      if instance.customer_id == id
        return instance
      end
    end
  end

  def find_by_invoice_id(id)
    instances.select do |instance|
      if instance.invoice_id == id
        return instance
      end
    end
  end

  def find_all_by_invoice_id(id)
    total = []
    instances.map do |instance|
      if instance.invoice_id == id
        total << instance
      end
    end
    return total
  end

  def find_by_unit_price(price)
    instances.select do |instance|
      if instance.price == price
        return instance
      end
    end
  end

end
