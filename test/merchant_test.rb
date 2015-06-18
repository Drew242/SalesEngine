require_relative '../test/test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_a_name
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal "Jim", merchant.name
  end

  def test_it_has_an_id
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal 42, merchant.id
  end

  def test_it_has_a_created_at_date
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal "date1", merchant.created
  end

  def test_id_has_an_updated_at_date
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal "date2", merchant.updated
  end

  def test_it_can_move_instances_up_to_its_repository_for_items_method
    repo = Minitest::Mock.new
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, repo)
    repo.expect(:find_all_items_by_merchant_id, [], [merchant.id])
    merchant.items
    repo.verify
  end


  def test_it_can_move_instances_up_to_its_repository_for_invoices_method
    repo = Minitest::Mock.new
    merchant = Merchant.new({id:"42", name:"Jim",
                              created_at: "date1",
                              updated_at: "date2"}, repo)
    repo.expect(:find_all_invoices_by_merchant_id, [], [merchant.id])
    merchant.invoices
    repo.verify
  end


end
