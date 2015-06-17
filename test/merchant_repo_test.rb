require 'minitest/autorun'
require 'csv'
require 'minitest/pride'
require_relative '../lib/merchant_repo'
require_relative '../lib/file_reader'



class MerchantRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/fixture.csv", __dir__)
  end

  def test_it_can_hold_a_new_merchant
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    refute merchants.empty?
  end

  def test_it_can_return_correct_size
    repo = MerchantRepository.new([{id: 2, name: "Joe"}, {id: 1, name: "Jim"}], "sales_engine")
    merchants = repo.manage
    result = repo.all
    assert_equal  2 , result.size

  end

  def test_it_returns_all_merchants
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.all
    result.map do |merchant|
      assert_equal Merchant, merchant.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    random = repo.random
    merchants.delete(random)
    refute merchants.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_name
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_by_name("klEin")
    assert_equal "2", result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_by_id("2")
    assert_equal "Klein, Rempel and Jones", result.name
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_by_updated_at("2012-03-27 16:12:25 UtC")
    assert_equal "6", result.id
  end

  def test_it_can_find_all_instances_based_off_of_first_name
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_all_by_name("WilliamSon")
    assert_equal 2, result.size
  end


  def test_it_can_find_all_instances_based_off_of_name
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_all_by_name("KleIn")
    assert_equal 1, result.count

  end

  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_all_by_id("2")
    assert_equal "Klein, Rempel and Jones", result[0].name

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_all_by_created_at("2012-03-27 14:53:59")
    assert_equal 6, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    merchants = repo.manage
    result = repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 5, result.size
  end

end
