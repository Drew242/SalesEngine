require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  def test_it_has_a_first_name
    customer = Customer.new({id:"42", first_name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal "Jim", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new({id:"42", first_name:"Jim",
                            created_at: "date1", last_name: "Beam",
                            updated_at: "date2"}, "repo")
    assert_equal "Beam", customer.last_name
  end

  def test_it_has_an_id
    customer = Customer.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal "42", customer.id
  end

  def test_it_has_a_created_at_date
    customer = Customer.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal "date1", customer.created
  end

  def test_id_has_an_updated_at_date
    customer = Customer.new({id:"42", name:"Jim",
                            created_at: "date1",
                            updated_at: "date2"}, "repo")
    assert_equal "date2", customer.updated
  end

end
