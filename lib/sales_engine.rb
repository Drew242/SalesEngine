require_relative 'file_reader'
require 'csv'
class SalesEngine

  def get_data
    reader        = FileReader.new
    @merchants    = reader.read("./data/merchants.csv")
    @customers    = reader.read("./data/customers.csv")
    @transactions = reader.read("./data/transactions.csv")
    @invoices     = reader.read("./data/invoices.csv")
    @invoice_items= reader.read("./data/invoice_items.csv")
    @items        = reader.read("./data/items.csv")
  end

  def startup
    get_data
    merchant_repo      = MerchantRepository.new(@merchants, self)
    customer_repo      = CustomerRepository.new(@customer, self)
    transactions_repo  = TransactionsRepository.new(@transactions, self)
    invoices_repo      = InvoiceRepository.new(@invoices, self)
    invoice_items_repo = InvoiceItemsRepository.new(@invoice_items, self)
    items_repo         = ItemsRepository.new(@items, self)
  end





end
