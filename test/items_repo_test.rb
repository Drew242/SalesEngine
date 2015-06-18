require 'minitest/autorun'
require 'csv'
require 'minitest/pride'
require_relative '../lib/items_repo'
require_relative '../lib/file_reader'

class ItemsRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/item_fixture.csv", __dir__)
  end

  def test_it_can_hold_a_new_item
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    refute repo.instances.empty?
  end

  def test_it_can_return_correct_size
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.all
    assert_equal  5 , result.size
  end

  def test_it_returns_all_items
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.all
    result.map do |items|
      assert_equal Items, items.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")

    random = repo.random
    items = repo.instances
    items.delete(random)
    refute items.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_name
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_name("Item Ea Voluptatum")
    assert_equal "3", result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_id("2")
    assert_equal "Item Autem Minima", result.name
  end

  def test_it_can_find_an_instance_based_off_of_description
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_description("Nihil autem sit odio inventore deleniti.")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_of_unit_price
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_unit_price("75107")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_of_merchant_id
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_merchant_id("1")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal "1", result.id
  end

end
