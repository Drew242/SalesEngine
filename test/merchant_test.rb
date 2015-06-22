require_relative '../test/test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_a_name
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal "Jim", merchant.name
  end

  def test_it_has_an_id
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 42, merchant.id
  end

  def test_it_has_a_created_at_date
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), merchant.created
  end

  def test_id_has_an_updated_at_date
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), merchant.updated
  end

  def test_it_can_move_instances_up_to_its_repository_for_items_method
    repo     = Minitest::Mock.new
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-03-25 09:54:09 UTC"}, repo)
    repo.expect(:find_all_items_by_merchant_id, [], [merchant.id])
    merchant.items
    repo.verify
  end


  def test_it_can_move_instances_up_to_its_repository_for_invoices_method
    repo     = Minitest::Mock.new
    merchant = Merchant.new({id:"42", name:"Jim",
                              created_at: "2012-03-25 09:54:09 UTC",
                              updated_at: "2012-03-25 09:54:09 UTC"}, repo)
    repo.expect(:find_all_invoices_by_merchant_id, [], [merchant.id])
    merchant.invoices
    repo.verify
  end

  def test_revenue_will_return_merchant_revenue
    engine   = SalesEngine.new
    repo     = MerchantRepository.new([{id:"1", name:"Jim",
                            created_at: "2012-03-25 09:54:09 UTC",
                            updated_at: "2012-03-25 09:54:09 UTC"}],engine)
    engine.invoice_repository = InvoiceRepository.new([{merchant_id: 1, id: 2,  created_at: "2012-03-26 09:54:09 UTC",
                                                      updated_at: "2012-03-26 09:54:09 UTC"}], engine)
    engine.invoice_item_repository = InvoiceItemsRepository.new([{id:25, invoice_id: 2, unit_price: "300", created_at: "2012-03-26 09:54:09 UTC",
                                                            updated_at: "2012-03-26 09:54:09 UTC", quantity: 3}], engine)
    engine.transaction_repository  = TransactionRepository.new([{id: 1, invoice_id: 2, result: "success", created_at: "2012-03-26 09:54:09 UTC",
                                                          updated_at: "2012-03-26 09:54:09 UTC"}], engine)
    engine.merchant_repository = repo

    merchant = repo.find_by_id(1)
    assert_equal 9.00, merchant.revenue.to_f
  end

  def test_revenue_will_return_merchant_revenue_from_specified_date
    skip
    engine   = SalesEngine.new
    repo     = MerchantRepository.new([{id:"1", name:"Jim",
                                        created_at: "2012-03-25 09:54:09 UTC",
                                        updated_at: "2012-03-25 09:54:09 UTC"},
                                        {id:"3", name:"Jim",
                                        created_at: "2012-03-25 09:54:09 UTC",
                                        updated_at: "2012-04-25 09:54:09 UTC"}],engine)
    engine.invoice_repository      = InvoiceRepository.new([{merchant_id: 1, id: 2, created_at: "2012-03-25 09:54:09 UTC",
                                    updated_at: "2012-04-25 09:54:09 UTC"},
                                    {merchant_id: 1, id: 3, created_at: "2012-03-25 09:54:09 UTC",
                                      updated_at: "2012-04-25 09:54:09 UTC"}], engine)
    engine.invoice_item_repository = InvoiceItemsRepository.new([{id:25, invoice_id: 2, unit_price: "300",
                                    quantity: 3,  created_at: "2012-03-25 09:54:09 UTC",
                                    updated_at: "2012-04-25 09:54:09 UTC"},
                                    {id:29, invoice_id: 3, unit_price: "900",
                                    quantity: 3,  created_at: "2012-03-25 09:54:09 UTC",
                                    updated_at: "2012-04-25 09:54:09 UTC"} ], engine)
    engine.transaction_repository  = TransactionRepository.new([{id: 1, invoice_id: 2, result: "success",  created_at: "2012-03-25 09:54:09 UTC",
                                                                updated_at: "2012-04-25 09:54:09 UTC"},
                                                              {id: 1, invoice_id: 3, result: "success",  created_at: "2012-03-25 09:54:09 UTC",
                                                                updated_at: "2012-04-25 09:54:09 UTC"}  ], engine)
    engine.merchant_repository     = repo
    merchant = repo.find_by_id(1)
    assert_equal 9.00, merchant.revenue("2012-03-25 09:54:09 UTC").to_f
  end

end
