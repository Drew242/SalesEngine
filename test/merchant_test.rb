require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_a_name
    merchant = Merchant.new(:"42", :Jim, :date1, :date2, "repo")
    assert_equal :Jim, merchant.name
  end

  def test_it_has_an_id
    merchant = Merchant.new(:"42", :Jim, :date1, :date2, "repo")
    assert_equal :"42", merchant.id
  end

  def test_it_has_a_created_at_date
    merchant = Merchant.new(:"42", :Jim, :date1, :date2, "repo")
    assert_equal :date1, merchant.created
  end

  def test_id_has_an_updated_at_date
    merchant = Merchant.new(:"42", :Jim, :date1, :date2, "repo")
    assert_equal :date2, merchant.updated
  end

end
