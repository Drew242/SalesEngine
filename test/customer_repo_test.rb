require 'minitest/autorun'
require 'csv'
require 'minitest/pride'
require './lib/customer_repo'
require 'file_reader'

class CustomerRepoTest < Minitest::Test


  def test_it_can_hold_a_new_customer
    data = FileReader.new.read("./test/customer_fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customer = repo.manage
    refute customer.empty?
  end

  def test_it_can_return_correct_size
    data = FileReader.new.read("./test/customer_fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    result = repo.all
    assert_equal  6 , result.size

  end

  def test_it_returns_all_customers
    data = FileReader.new.read("./test/fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    result = repo.all
    result.map do |customer|
      assert_equal Customer, customer.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read("./test/customer_fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    random = repo.random
    customers.delete(random)
    refute customers.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_first_name
    data = FileReader.new.read("./test/customer_fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    result = repo.find_by_first_name("Mariah")
    assert_equal "3", result.id
  end

  def test_it_can_find_an_instance_based_off_of_last_name
    data = FileReader.new.read("./test/customer_fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    result = repo.find_by_last_name("Braun")
    assert_equal "4", result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read("./test/customer_fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    result = repo.find_by_id("2")
    assert_equal "Cecelia", result.first_name
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read("./test/customer_fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    result = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read("./test/fixture.csv")
    repo = CustomerRepository.new(data, "sales_engine")
    customers = repo.manage
    result = repo.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "6", result.id
  end

end


