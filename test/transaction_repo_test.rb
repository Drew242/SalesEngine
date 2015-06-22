require_relative '../test/test_helper'


class TransactionRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/transactions.csv", __dir__)
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
      assert_equal Transaction, transaction.class
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
    result = repo.find_by_id(2)
    assert_equal 2, result.invoice_id
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_all_by_id(5)
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

  def test_it_can_find_all_instances_based_off_of_result
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_all_by_result("success")
    assert_equal 6, result.size
  end

  def test_it_can_find_an_instance_based_off_of_cc_number
    data = FileReader.new.read(@file)
    repo = TransactionRepository.new(data, "sales_engine")
    result = repo.find_by_credit_card_number("4654405418249632")
    assert_equal 1, result.id
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_invoice_search
    engine = Minitest::Mock.new
    repo = TransactionRepository.new([{id: 2, invoice_id: "37"},
                                      {id: 1, invoice_id: "37"}], engine)
    engine.expect(:find_an_invoice_by_invoice_id, [], [37])
    repo.find_an_invoice_by_invoice_id(37)
    engine.verify
  end

end
