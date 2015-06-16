require 'merchant'
class MerchantParser
  attr_reader :data
  def initialize(repo)
    @repo = repo
  end

  def convert(data)
    @data = data
    return Merchant.new(get_id,get_name,get_created,get_updated, @repo)
  end

  def get_name
    data[:name]
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
