class Item

  attr_reader :id,
              :name,
              :description,
              :price,
              :merchant_id,
              :created,
              :updated
  def initialize(data, repo)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @price       = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created     = data[:created_at]
    @updated     = data[:updated_at]
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Item #{id}"
  end
end
