require_relative '../test/test_helper'


class ItemsRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/items.csv", __dir__)
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
      assert_equal Item, items.class
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
    assert_equal 3, result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_id(2)
    assert_equal "Item Autem Minima", result.name
  end

  def test_it_can_find_an_instance_based_off_of_description
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_description("Nihil autem sit odio inventore deleniti.")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_of_unit_price
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_unit_price("75107")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_of_merchant_id
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_merchant_id(1)
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = ItemsRepository.new(data, "sales_engine")
    result = repo.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_invoice_items
    engine = Minitest::Mock.new
    repo = ItemsRepository.new([{id: 2, name: "Joe"}], engine)
    engine.expect(:find_invoice_items_by_invoice_id, [], [2])
    repo.find_invoice_items_by_invoice_id(2)
    engine.verify
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_merchant
    engine = Minitest::Mock.new
    repo = ItemsRepository.new([{id: 2, name: "Joe"}], engine)
    engine.expect(:find_merchant_by_merchant_id, [], [2])
    repo.find_merchant_by_merchant_id(2)
    engine.verify
  end

end
