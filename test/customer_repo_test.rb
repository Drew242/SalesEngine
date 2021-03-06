require_relative '../test/test_helper'


class CustomerRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/customers.csv", __dir__)
  end

  def test_it_can_hold_a_new_customer
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    refute repo.instances.empty?
  end

  def test_it_can_return_correct_size
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.all
    assert_equal  12 , result.size

  end

  def test_it_returns_all_customers
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.all
    result.map do |customer|
      assert_equal Customer, customer.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    random = repo.random
    customers = repo.instances
    customers.delete(random)
    refute customers.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_first_name
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.find_by_first_name("MarIah")
    assert_equal 3, result.id
  end

  def test_it_can_find_all_based_off_of_first_name
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.find_all_by_first_name("MarIah")
    assert_equal 1, result.size
  end

  def test_it_can_find_an_instance_based_off_of_last_name
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.find_by_last_name("BrAun")
    assert_equal 4, result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.find_by_id(2)
    assert_equal "Cecelia", result.first_name
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = CustomerRepository.new(data, "sales_engine")
    result = repo.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_invoices_search
    engine = Minitest::Mock.new
    repo = CustomerRepository.new([{id: 2, name: "Joe",  created_at: "2012-03-26 09:54:09 UTC",
                                  updated_at: "2012-03-26 09:54:09 UTC"},
                                  {id: 1, name: "Jim",  created_at: "2012-03-26 09:54:09 UTC",
                                    updated_at: "2012-03-26 09:54:09 UTC"}] , engine)
    engine.expect(:find_all_invoices_by_id, [], [2])
    repo.find_all_invoices_by_id(2)
    engine.verify
  end

end
