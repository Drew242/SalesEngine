class Merchant
  attr_reader :id, :name, :created, :updated
  def initialize(id,name,created_at,updated_at, repo)
    @id      = id
    @name    = name
    @created = created_at
    @updated = updated_at
    @repo    = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Merchant #{id}"
  end
end
