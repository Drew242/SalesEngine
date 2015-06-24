require_relative '../test/test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  def test_it_has_a_first_name
    customer = Customer.new({id:"42", first_name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-04-25 09:54:09 UTC"}, "repo")
    assert_equal "Jim", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new({id:"42", first_name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC", last_name: "Beam",
                            updated_at: "2012-04-25 09:54:09 UTC"}, "repo")
    assert_equal "Beam", customer.last_name
  end

  def test_it_has_an_id
    customer = Customer.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-04-25 09:54:09 UTC"}, "repo")
    assert_equal 42, customer.id
  end

  def test_it_has_a_created_at_date
    customer = Customer.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-04-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), customer.created
  end

  def test_it_has_an_updated_at_date
    customer = Customer.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-04-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-04-25 09:54:09 UTC"), customer.updated
  end

  def test_it_can_move_instances_up_to_its_repository_for_invoices_method
    repo = Minitest::Mock.new
    customer = Customer.new({id:"42", name:"Jim",
                              created_at: "2012-03-25 09:54:09 UTC",
                              updated_at: "2012-04-25 09:54:09 UTC"}, repo)
    repo.expect(:find_all_invoices_by_id, [], [customer.id])
    customer.invoices
    repo.verify
  end

  def test_favorite_merchant_returns_merchant_with_most_transactions

    engine = SalesEngine.new
    reader = FileReader.new
    repo   = CustomerRepository.new(reader.read(File.expand_path("../test/fixtures/customers.csv", __dir__)),
                                      engine)
    engine.invoice_repository     = InvoiceRepository.new(reader.read(File.expand_path("../test/fixtures/invoices.csv", __dir__)),
                                      engine)
    engine.merchant_repository    = MerchantRepository.new(reader.read(File.expand_path("../test/fixtures/merchants.csv", __dir__)),
                                      engine)
    engine.transaction_repository = TransactionRepository.new(reader.read(File.expand_path("../test/fixtures/transactions.csv", __dir__)),
                                      engine)
    engine.customer_repository    = repo

    customer = repo.find_by_id(2)
    assert_equal "Osinski, Pollich and Koelpin", customer.favorite_merchant.name
  end

  def test_transactions_returns_transactions_associated_with_customer

    engine = SalesEngine.new
    reader = FileReader.new
    repo   = CustomerRepository.new(reader.read(File.expand_path("../test/fixtures/customers.csv", __dir__)),
                                      engine)
    engine.invoice_repository     = InvoiceRepository.new(reader.read(File.expand_path("../test/fixtures/invoices.csv", __dir__)),
                                      engine)
    engine.transaction_repository = TransactionRepository.new(reader.read(File.expand_path("../test/fixtures/transactions.csv", __dir__)),
                                      engine)
    engine.customer_repository    = repo

    customer = repo.find_by_id(3)
    assert_equal 3, customer.transactions.size
  end

end
