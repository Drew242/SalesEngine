require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_it_has_a_first_name
    customer = Customer.new(:"42", :Jim, :Beam, :date1, :date2, "repo")
    assert_equal :Jim, customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new(:"42", :Jim, :Beam, :date1, :date2, "repo")
    assert_equal :Beam, customer.last_name
  end

  def test_it_has_an_id
    customer = Customer.new(:"42", :Jim, :Beam, :date1, :date2, "repo")
    assert_equal :"42", customer.id
  end

  def test_it_has_a_created_at_date
    customer = Customer.new(:"42", :Jim, :Beam, :date1, :date2, "repo")
    assert_equal :date1, customer.created
  end

  def test_id_has_an_updated_at_date
    customer = Customer.new(:"42", :Jim, :Beam, :date1, :date2, "repo")
    assert_equal :date2, customer.updated
  end

end
