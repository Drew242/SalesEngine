require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'

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
    assert_equal "42", merchant.id
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

  def test_it_can_move_instances_up_to_its_repository
    repo = Minitest::Mock.new
    merchant = Merchant.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, repo)
    repo.expect(:pass, [], [merchant.id])
    merchant.items
    repo.verify
  end

end
