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

end
