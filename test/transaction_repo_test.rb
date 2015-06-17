require 'minitest/autorun'
require 'csv'
require 'minitest/pride'
require_relative '../lib/transaction_repo'
require_relative '../lib/file_reader'



class TransactionRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/transaction_fixture.csv", __dir__)
  end

  def test_it_can_hold_a_new_transaction
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")

    refute repo.instances.empty?
  end

  def test_it_can_return_correct_size
    repo = TransactionRepository.new([{id: 2, invoice_id: "37"}, {id: 1, invoice_id: "37"}], "sales_engine")
    result = repo.all
    assert_equal  2 , result.size

  end

  def test_it_returns_all_merchants
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.all
    result.map do |transaction|
      assert_equal Transactions, transaction.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    random = repo.random
    transactions = repo.instances
    transactions.delete(random)
    refute transactions.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_by_id("4")
    assert_equal "4", result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_by_id("2")
    assert_equal "2", result.invoice_id
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_all_by_id("5")
    assert_equal 2, result.size

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, result.size
  end



end
