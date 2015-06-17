require_relative '../lib/items'

class ItemParser
  attr_reader :data

  def initialize(repo)
    @repo = repo
  end

  def convert(data)
    @data = data
    return Items.new(get_id,get_name,get_description,
    get_unit_price,get_merchant_id,
    get_created,get_updated, @repo)
  end

  def get_name
    data[:name]
  end

  def get_description
    data[:description]
  end

  def get_id
    data[:id]
  end

  def get_unit_price
    data[:unit_price]
  end

  def get_merchant_id
    data[:merchant_id]
  end

  def get_created
    data[:created_at]
  end

  def get_updated
    data[:updated_at]
  end
end
