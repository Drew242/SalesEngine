require_relative '../lib/file_reader'
require_relative '../lib/merchant_repo'
require_relative '../lib/customer_repo'
require_relative '../lib/transaction_repo'
require_relative '../lib/invoice_repo'
require_relative '../lib/invoice_items_repo'
require_relative '../lib/items_repo'
require 'csv'

class SalesEngine
 attr_accessor :merchant_repo, :customer_repo, :transaction_repo,
               :invoice_repo, :invoice_items_repo, :items_repo

  def startup( dir = "data")
    reader         = FileReader.new
    merchants      = reader.read(File.expand_path("./#{dir}/merchants.csv"))
    customers      = reader.read(File.expand_path("./#{dir}/customers.csv"))
    transactions   = reader.read(File.expand_path("./#{dir}/transactions.csv"))
    invoices       = reader.read(File.expand_path("./#{dir}/invoices.csv"))
    invoice_items  = reader.read(File.expand_path("./#{dir}/invoice_items.csv"))
    items          = reader.read(File.expand_path("./#{dir}/items.csv"))
    @merchant_repo      = MerchantRepository.new(merchants, self)
    @customer_repo      = CustomerRepository.new(customer, self)
    @transactions_repo  = TransactionsRepository.new(transactions, self)
    @invoice_repo       = InvoiceRepository.new(invoices, self)
    @invoice_items_repo = InvoiceItemsRepository.new(invoice_items, self)
    @items_repo         = ItemsRepo.new(items, self)
  end

  def find_all_items_by_merchant_id(instance)
    @items_repo.find_all_by_merchant_id(instance)
  end

  def find_all_invoices_by_merchant_id(instance)
    @invoice_repo.find_all_by_merchant_id(instance)
  end

  def find_all_transactions_by_invoice_id(instance)
    @transaction_repo.find_all_by_invoice_id(instance)
  end

  def find_all_invoice_items_by_invoice_id(instance)
    @invoice_items_repo.find_all_by_invoice_id(instance)
  end

  def find_all_items_by_invoice_id(instance)
    result = @invoice_items_repo.find_by_invoice_id(instance)
    @items_repo.find_all_by_id(result.item_id)
  end

  def find_a_customer_by_customer_id(instance)
    @customer_repo.find_by_id(instance)
  end

  def find_a_merchant_by_merchant_id(instance)
    @merchant_repo.find_by_id(instance)
  end

  def find_an_invoice_by_invoice_id(instance)
    @invoice_repo.find_by_id(instance)
  end

  def find_an_item_by_item_id(instance)
    @items_repo.find_by_id(instance)
  end

  def find_invoice_items_by_invoice_id(instance)
    @invoice_items_repo.find_by_item_id(instance)
  end

  def find_a_merchant_by_merchant_id(instance)
    @merchant_repo.find_by_id(instance)
  end

  def find_an_invoice_item_by_invoice_id(instance)
    @invoice_repo.find_by_id(instance)
  end

  def find_invoices_by_id(instance)
    @invoice_repo.find_by_customer_id(instance)
  end

end

if __FILE__ == $0
  SalesEngine.new.startup
end
