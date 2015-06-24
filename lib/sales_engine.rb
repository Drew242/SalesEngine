require 'bigdecimal'
require_relative '../lib/file_reader'
require_relative '../lib/merchant_repo'
require_relative '../lib/customer_repo'
require_relative '../lib/transaction_repo'
require_relative '../lib/invoice_repo'
require_relative '../lib/invoice_items_repo'
require_relative '../lib/items_repo'
require 'csv'

class SalesEngine
  attr_accessor :merchant_repository, :customer_repository,
  :transaction_repository,
  :invoice_repository, :invoice_item_repository,
   :item_repository

  def initialize (path = "data/")
    @dir = path
  end

  def startup
    reader         = FileReader.new
    merchants      = reader.read("#{@dir}/merchants.csv")
    customers      = reader.read("#{@dir}/customers.csv")
    transactions   = reader.read("#{@dir}/transactions.csv")
    invoices       = reader.read("#{@dir}/invoices.csv")
    invoice_items  = reader.read("#{@dir}/invoice_items.csv")
    items          = reader.read("#{@dir}/items.csv")
    @merchant_repository     = MerchantRepository.new(merchants, self)
    @customer_repository     = CustomerRepository.new(customers, self)
    @transaction_repository  = TransactionRepository.new(transactions, self)
    @invoice_repository      = InvoiceRepository.new(invoices, self)
    @invoice_item_repository = InvoiceItemsRepository.new(invoice_items, self)
    @item_repository         = ItemsRepository.new(items, self)
  end

  def find_all_items_by_merchant_id(instance)
    item_repository.find_all_by_merchant_id(instance)
  end

  def find_all_invoices_by_merchant_id(instance)
    invoice_repository.find_all_by_merchant_id(instance)
  end

  def find_all_transactions_by_invoice_id(instance)
    transaction_repository.find_all_by_invoice_id(instance)
  end

  def find_all_invoice_items_by_invoice_id(instance)
    invoice_item_repository.find_all_by_invoice_id(instance)
  end

  def find_all_items_by_invoice_id(instance)
    result = invoice_item_repository.find_all_by_invoice_id(instance)
    return result.map do |invoice_item|
      item_repository.find_all_by_id(invoice_item.item_id)
    end.flatten
  end

  def find_a_customer_by_customer_id(instance)
    customer_repository.find_by_id(instance)
  end

  def find_a_customer_by_invoice_id(instance)
    customer_repository.find_by_id(instance)
  end

  def find_merchant_by_merchant_id(instance)
    merchant_repository.find_by_id(instance)
  end

  def find_an_invoice_by_invoice_id(instance)
    invoice_repository.find_by_id(instance)
  end

  def find_an_item_by_item_id(instance)
    item_repository.find_by_id(instance)
  end

  def find_invoice_items_by_item_id(instance)
    invoice_item_repository.find_all_by_item_id(instance)
  end

  def find_an_invoice_by_invoice_id(instance)
    invoice_repository.find_by_id(instance)
  end

  def find_all_invoices_by_id(instance)
    invoice_repository.find_all_by_customer_id(instance)
  end

end

if __FILE__ == $0
  SalesEngine.new.startup
end
