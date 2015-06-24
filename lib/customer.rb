require 'bigdecimal'
class Customer
  attr_reader :id, :first_name, :last_name, :created, :updated
  def initialize(data, repo)
    @id          = data[:id].to_i
    @first_name  = data[:first_name]
    @last_name   = data[:last_name]
    @created     = Date.parse(data[:created_at])
    @updated     = Date.parse(data[:updated_at])
    @repo        = repo
  end

  def inspect
    to_s
  end

  def to_s
    "Customer #{id}"
  end

  def invoices
    @invoices ||= @repo.find_all_invoices_by_id(id)
  end

  def favorite_merchant
    merchants = get_successful_transactions(invoices).map do |invoice|
      invoice.merchant
    end
    merchant_groups = group_merchants(merchants)
    top_merchant = find_most_used_merchant(merchant_groups)
    top_merchant[0]
  end

  def get_successful_transactions(invoices)
    invoices.map do |invoice|
      transactions ||= invoice.transactions
      transactions.map do|transaction|
        transaction.result == "success"
        invoice
      end
    end.flatten
  end

  def find_most_used_merchant(merchant_groups)
    merchant_groups.max_by do |group|
      group.size
    end
  end

  def group_merchants(merchants)
    merchants.group_by do |merchant|
      merchant.name
    end.values
  end

  def transactions
    invoices.map do |invoice|
      invoice.transactions.map do |transaction|
        transaction
      end
    end


  end
end
