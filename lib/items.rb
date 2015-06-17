class Items

  attr_reader :id,
              :name,
              :description,
              :price,
              :merchant_id,
              :created,
              :updated
  def initialize(id,name,description,
                unit_price,merchant_id,
                created_at,updated_at, repo)
    @id          = id
    @name        = name
    @description = description
    @price       = unit_price
    @merchant_id = merchant_id
    @created     = created_at
    @updated     = updated_at
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Item #{id}"
  end
end
