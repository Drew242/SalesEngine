module ListSearch
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

  def find_all_by_first_name(first_name)

    result =[]
    instances.each do |instance|
      if instance.name.include?(first_name)
        result << instance
      end
    end
    return result

  end

  def find_all_by_id(id)

    result =[]
    instances.each do |instance|
      if instance.id.include?(id)
        result << instance
      end
    end
    return result

  end

  def find_all_by_created_at(created_at)

    result =[]
    instances.each do |instance|
      if instance.created.include?(created_at)
        result << instance
      end
    end
    return result

  end

  def find_all_by_updated_at(updated_at)

    result =[]
    instances.each do |instance|
      if instance.updated.include?(updated_at)
        result << instance
      end
    end
    return result

  end
end
