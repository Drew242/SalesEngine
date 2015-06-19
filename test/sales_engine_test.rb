require_relative '../test/test_helper'
require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def test_it_can_have_item_repo_look_for_merchant_id
    engine            = SalesEngine.new
    repo              = ItemsRepository.new([{id:"2", name:"Item_que", decription:"something",
                                       unit_price:"one", merchant_id:"7",
                                      created_at:"date1", updated_at:"date2"}], engine)
    engine.items_repo = repo
    result            = engine.find_all_items_by_merchant_id(7)
    assert_equal 2, result[0].id
  end

  def test_it_can_have_invoice_repo_look_for_merchant_id
    engine            = SalesEngine.new
    repo              = InvoiceRepository.new([{id:"2", name:"Item_que", decription:"something",
                                       unit_price:"one", merchant_id:"7",
                                      created_at:"date1", updated_at:"date2"}], engine)
    engine.invoice_repo = repo
    result            = engine.find_all_invoices_by_merchant_id(7)
    assert_equal 2, result[0].id
  end

  def test_it_can_have_transaction_repo_look_for_invoice_id
    engine     = SalesEngine.new
    repo       = TransactionRepository.new([{id:"42", invoice_id:"2",
                credit_card_number:"4654405418249632",
                credit_card_expiration_data:"" ,result:"success",
                created_at:"date1", updated_at:"date2"}], engine)
    engine.transaction_repo = repo
    result                  = engine.find_all_transactions_by_invoice_id(2)
    assert_equal 42, result[0].id
  end

  def test_it_can_have_invoice_items_repo_look_for_invoice_id
    engine    = SalesEngine.new
    repo      = InvoiceItemsRepository.new([{id:"4", invoice_id: "1",customer_id:"67",merchant_id:"5",
                                                status:"shipped", quantity:"9", unit_price: "23",
                                                created_at:"2012-03-25 09:54:09 UTC",
                                                updated_at:"2012-03-25 09:54:09 UTC"}], engine)
    engine.invoice_items_repo = repo
    result                    = engine.find_all_invoice_items_by_invoice_id(1)
    assert_equal 4, result[0].id
  end

  def test_it_can_have_items_repo_look_for_invoice_id
    engine    = SalesEngine.new
    repo      = InvoiceItemsRepository.new([{id:"4", invoice_id: "1",item_id:"67",merchant_id:"5",
                                            status:"shipped", quantity:"9", unit_price: "23",
                                            created_at:"2012-03-25 09:54:09 UTC",
                                            updated_at:"2012-03-25 09:54:09 UTC"}], engine)
    items_repo      = ItemsRepository.new([{id:"67", name:"Item_que", decription:"something",
                                            unit_price:"one", merchant_id:"7", invoice_id: "23",
                                            created_at:"date1", updated_at:"date2"}], engine)
    engine.invoice_items_repo = repo
    engine.items_repo         = items_repo
    result                    = engine.find_all_items_by_invoice_id(1)
    assert_equal "Item_que", result[0].name
  end



  def test_it_will_return_an_empty_array_if_no_match_for_items
    engine    = SalesEngine.new
    repo      = InvoiceItemsRepository.new([{id:"4", invoice_id: "1",item_id:"67",merchant_id:"5",
                                            status:"shipped", quantity:"9", unit_price: "23",
                                            created_at:"2012-03-25 09:54:09 UTC",
                                            updated_at:"2012-03-25 09:54:09 UTC"}], engine)
    items_repo      = ItemsRepository.new([{id:"2", name:"Item_que", decription:"something",
                                            unit_price:"one", merchant_id:"7", invoice_id: "23",
                                            created_at:"date1", updated_at:"date2"}], engine)
    engine.invoice_items_repo = repo
    engine.items_repo         = items_repo
    result                    = engine.find_all_items_by_invoice_id(1)
    assert_equal [], engine.find_all_items_by_invoice_id(1)
  end

  def test_it_can_have_customer_repo_look_for_id
    engine    = SalesEngine.new
    repo      = CustomerRepository.new([{id:"42", first_name:"Jim",
                                        created_at: "date1",
                                        updated_at: "date2"}], engine)
    engine.customer_repo = repo
    result            = engine.find_a_customer_by_customer_id(42)
    assert_equal "Jim", result.first_name
  end

  def test_it_can_have_merchant_repo_look_for_id
    engine    = SalesEngine.new
    repo      = MerchantRepository.new([{id:"42", name:"Jim",
                                      created_at: "date1",
                                      updated_at: "date2"}], engine)
    engine.merchant_repo = repo
    result            = engine.find_a_merchant_by_merchant_id(42)
    assert_equal "Jim", result.name
  end

  def test_it_can_have_invoice_item_repo_look_for_invoice
    engine    = SalesEngine.new
    repo      = InvoiceRepository.new([{id:"4",customer_id:"67",merchant_id:"5",
                                      status:"shipped",
                                      created_at:"2012-03-25 09:54:09 UTC",
                                      updated_at:"2012-03-25 09:54:09 UTC"}], engine)
    engine.invoice_repo = repo
    result              = engine.find_an_invoice_by_invoice_id(4)
    assert_equal "shipped", result.status
  end

  def test_it_can_have_item_repo_look_for_an_item
    engine    = SalesEngine.new
    repo      = ItemsRepository.new([{id:"2", name:"Item_que", decription:"something",
                                      unit_price:"one", merchant_id:"7",
                                      created_at:"date1", updated_at:"date2"}], engine)
    engine.items_repo   = repo
    result              = engine.find_an_item_by_item_id(2)
    assert_equal "Item_que", result.name
  end

  def test_it_can_have_invoice_item_repo_look_for_invoice_items
    engine    = SalesEngine.new
    repo      = InvoiceItemsRepository.new([{id:"4", invoice_id: "1",item_id:"67",merchant_id:"5",
                                            status:"shipped", quantity:"9", unit_price: "23",
                                            created_at:"2012-03-25 09:54:09 UTC",
                                            updated_at:"2012-03-25 09:54:09 UTC"}], engine)
    engine.invoice_items_repo   = repo
    result                      = engine.find_invoice_items_by_invoice_id(67)
    assert_equal 4, result.id
  end

  def test_it_can_have_merchant_repo_look_for_merchant
    engine    = SalesEngine.new
    repo      = MerchantRepository.new([{id:"42", name:"Jim",
                                      created_at: "date1",
                                      updated_at: "date2"}], engine)
    engine.merchant_repo   = repo
    result                 = engine.find_a_merchant_by_merchant_id(42)
    assert_equal "Jim", result.name
  end

  def test_it_can_have_invoice_repo_look_for_invoice_for_transaction_items
    engine    = SalesEngine.new
    repo      = InvoiceRepository.new([{id:"4",customer_id:"67",merchant_id:"5",
                                      status:"shipped",
                                      created_at:"2012-03-25 09:54:09 UTC",
                                      updated_at:"2012-03-25 09:54:09 UTC"}], engine)
    engine.invoice_repo    = repo
    result                 = engine.find_an_invoice_by_invoice_id(4)
    assert_equal 67, result.customer_id
  end

  def test_it_can_have_invoice_repo_look_for_invoice_for_Customer_items
    engine    = SalesEngine.new
    repo      = InvoiceRepository.new([{id:"4",customer_id:"67",merchant_id:"5",
                                      status:"shipped",
                                      created_at:"2012-03-25 09:54:09 UTC",
                                      updated_at:"2012-03-25 09:54:09 UTC"}], engine)
    engine.invoice_repo    = repo
    result                 = engine.find_invoices_by_id(67)
    assert_equal 4, result.id
  end

end
