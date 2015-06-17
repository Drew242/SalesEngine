require 'minitest/autorun'
require 'csv'
require 'minitest/pride'
require_relative '../lib/invoice_items_repo'
require_relative '../lib/file_reader'

class InvoiceItemsRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/invoice_items_fixture.csv", __dir__)
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
    assert_equal  6 , result.size

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
    result = repo.find_by_id("2")
    assert_equal "9", result.quantity
  end

  def test_it_can_find_an_instance_based_off_of_quantity
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_quantity("9")
    assert_equal "2", result.id
  end

  def test_it_can_find_all_instances_based_off_of_quantity
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_quantity("5")
    assert_equal 2 , result.size
  end

  def test_it_can_find_all_instances_based_off_of_unit_price
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_unit_price("13635")
    assert_equal 3 , result.size
  end

  def test_it_can_find_an_instance_based_off_of_unit_price
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_unit_price("23324")
    assert_equal "528" , result.item_id
  end


  def test_it_can_find_an_instance_based_off_of_invoice_id
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_invoice_id("2")
    assert_equal "9" , result.quantity
  end

  def test_it_can_find_all_instances_based_off_of_invoice_id
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_invoice_id("1")
    assert_equal 5 , result.size
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "1", result.id
  end


  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoices_items = repo.manage
    result = repo.find_all_by_id("2")
    assert_equal "9", result[0].quantity

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 6, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read(@file)
    repo = InvoiceItemsRepository.new(data, "sales_engine")
    invoice_items = repo.manage
    result = repo.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 6, result.size
  end

end
