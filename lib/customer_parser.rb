require_relative '../lib/customer'
class CustomerParser
  attr_reader :data
  def initialize(repo)
    @repo = repo
  end

  def convert(data)
    @data = data
    return Customer.new(get_id,get_first_name,get_last_name,get_created,get_updated, @repo)
  end

  def get_first_name
    data[:first_name]
  end

  def get_last_name
    data[:last_name]
  end

  def get_id
    data[:id]
  end

  def get_created
    data[:created_at]
  end

  def get_updated
    data[:updated_at]
  end

end
