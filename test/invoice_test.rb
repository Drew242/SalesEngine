require_relative '../test/test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def test_it_has_a_status
    invoice = Invoice.new({id:"4",customer_id:"67",merchant_id:"5",
    status:"shipped",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal "shipped", invoice.status
  end

  def test_it_has_a_customer_id
    invoice = Invoice.new({id:"4",customer_id:"67",merchant_id:"5",
    status:"shipped",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 67, invoice.customer_id
  end

  def test_it_has_an_id
    invoice = Invoice.new({id:"4",customer_id:"67",merchant_id:"5",
    status:"shipped",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 4, invoice.id
  end

  def test_it_has_a_merchant_id
    invoice = Invoice.new({id:"4",customer_id:"67",merchant_id:"5",
    status:"shipped",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 5, invoice.merchant_id
  end

  def test_it_has_a_created_at_date
    invoice = Invoice.new({id:"4",customer_id:"67",merchant_id:"5",
    status:"shipped",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), invoice.created
  end

  def test_id_has_an_updated_at_date
    invoice = Invoice.new({id:"4",customer_id:"67",merchant_id:"5",
    status:"shipped",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), invoice.updated
  end

  def test_it_can_move_instances_up_to_its_repo_for_transactions
    repo = Minitest::Mock.new
    invoice = Invoice.new({id: 2, name: "Joe",  created_at: "2012-03-26 09:54:09 UTC",
                          updated_at: "2012-03-26 09:54:09 UTC"}, repo)
    repo.expect(:find_all_transactions_by_invoice_id, [], [invoice.id])
    invoice.transactions
    repo.verify
  end

  def test_it_can_move_instances_up_to_its_repo_for_invoice_items
    repo = Minitest::Mock.new
    invoice = Invoice.new({id: 2, name: "Joe",  created_at: "2012-03-26 09:54:09 UTC",
                          updated_at: "2012-03-26 09:54:09 UTC"}, repo)
    repo.expect(:find_all_invoice_items_by_invoice_id, [], [invoice.id])
    invoice.invoice_items
    repo.verify
  end

  def test_it_can_move_instances_up_to_its_repo_for_items
    repo = Minitest::Mock.new
    invoice = Invoice.new({id: 2, name: "Joe",  created_at: "2012-03-26 09:54:09 UTC",
                          updated_at: "2012-03-26 09:54:09 UTC"}, repo)
    repo.expect(:find_all_items_by_invoice_id, [], [invoice.id])
    invoice.items
    repo.verify
  end

  def test_it_can_move_instances_up_to_its_repo_for_a_customer
    repo = Minitest::Mock.new
    invoice = Invoice.new({id: 2, name: "Joe", customer_id: "2",  created_at: "2012-03-26 09:54:09 UTC",
                          updated_at: "2012-03-26 09:54:09 UTC"}, repo)
    repo.expect(:find_a_customer_by_invoice_id, [], [invoice.customer_id])
    invoice.customer
    repo.verify
  end

  def test_it_can_move_instances_up_to_its_repo_for_a_merchant
    repo = Minitest::Mock.new
    invoice = Invoice.new({id: 2, name: "Joe", merchant_id: "5",
                          created_at: "2012-03-26 09:54:09 UTC",
                          updated_at: "2012-03-26 09:54:09 UTC"}, repo)
    repo.expect(:find_a_merchant_by_merchant_id, [], [invoice.merchant_id])
    invoice.merchant
    repo.verify
  end

  def test_charge_creates_a_new_transaction
    engine = SalesEngine.new
    engine.transaction_repository = TransactionRepository.new([{id: 2, invoice_id: "37",  created_at: "2012-03-26 09:54:09 UTC",
                                    updated_at: "2012-03-26 09:54:09 UTC"},
                                    {id: 1, invoice_id: "37",  created_at: "2012-03-26 09:54:09 UTC",
                                    updated_at: "2012-03-26 09:54:09 UTC"}], engine)
    repo = InvoiceRepository.new([{id:"4",customer_id:"67",merchant_id:"5",
                                status:"shipped",
                                created_at:"2012-03-25 09:54:09 UTC",
                                updated_at:"2012-03-25 09:54:09 UTC"}], engine )

    merchant_repo = MerchantRepository.new([{id: 5, name: "Joe",  created_at: "2012-03-26 09:54:09 UTC",
                              updated_at: "2012-03-26 09:54:09 UTC"}], "sales_engine")
    engine.invoice_repository  = repo
    engine.merchant_repository = merchant_repo
    invoice = repo.find_by_id(4)
    invoice.charge({credit_card_number: "4444333322221111",
                    credit_card_expiration: "10/13", result: "success"})
    assert_equal 3, engine.transaction_repository.instances.size
  end


end
