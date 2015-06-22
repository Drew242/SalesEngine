require_relative '../test/test_helper'


class InvoiceItemsRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/invoice_items.csv", __dir__)
  end

  def test_it_can_hold_a_new_invoice_item
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")

    refute repo.instances.empty?
  end

  def test_it_can_return_correct_size
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    result = repo.all
    assert_equal  8 , result.size

  end

  def test_it_returns_all_invoice_items
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    result = repo.all
    result.map do |invoice|
      assert_equal InvoiceItem, invoice.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.instances
    random = repo.random
    invoice_items.delete(random)
    refute repo.all.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_id(2)
    assert_equal 9, result.quantity
  end

  def test_it_can_find_an_instance_based_off_of_quantity
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_quantity(9)
    assert_equal 2, result.id
  end

  def test_it_can_find_all_instances_based_off_of_quantity
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_quantity(5)
    assert_equal 3 , result.size
  end

  def test_it_can_find_all_instances_based_off_of_unit_price
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_unit_price(BigDecimal.new("136.35"))
    assert_equal 4 , result.size
  end

  def test_it_can_find_an_instance_based_off_of_unit_price
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_unit_price(BigDecimal.new("233.24"))
    assert_equal 528 , result.item_id
  end


  def test_it_can_find_an_instance_based_off_of_invoice_id
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_invoice_id(8)
    assert_equal 5 , result.quantity
  end

  def test_it_can_find_all_instances_based_off_of_invoice_id
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_invoice_id(1)
    assert_equal 1 , result.size
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, result.id
  end


  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoices_items = repo.manage
    result = repo.find_all_by_id(2)
    assert_equal 9, result[0].quantity

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 8, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 8, result.size
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_items
    engine = Minitest::Mock.new
    repo = InvoiceItemsRepository.new([{id: 2, name: "Joe", unit_price:"455555"}], engine)
    engine.expect(:find_an_invoice_by_invoice_id, [], [2])
    repo.find_an_invoice_by_invoice_id(2)
    engine.verify
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_items
    engine = Minitest::Mock.new
    repo = InvoiceItemsRepository.new([{id: 2, name: "Joe", item_id: 3, unit_price:"455555"}], engine)
    engine.expect(:find_an_item_by_item_id, [], [3])
    repo.find_an_item_by_item_id(3)
    engine.verify
  end

end
