require 'minitest/autorun'
require 'csv'
require 'minitest/pride'
require './lib/invoice_repo'
require 'file_reader'

class InvoiceRepoTest < Minitest::Test


  def test_it_can_hold_a_new_invoice
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    refute invoices.empty?
  end

  def test_it_can_return_correct_size
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.all
    assert_equal  6 , result.size

  end

  def test_it_returns_all_invoices
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.all
    result.map do |invoice|
      assert_equal Invoice, invoice.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    random = repo.random
    invoices.delete(random)
    refute invoices.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_name
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_first_name("Klein")
    assert_equal "2", result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_id("2")
    assert_equal "Klein, Rempel and Jones", result.name
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_updated_at("2012-03-27 16:12:25 UTC")
    assert_equal "6", result.id
  end

  def test_it_can_find_all_instances_based_off_of_first_name
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_all_by_first_name("Williamson")
    assert_equal 2, result.size

  end

  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_all_by_id("2")
    assert_equal "Klein, Rempel and Jones", result[0].name

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_all_by_created_at("2012-03-27 14:53:59")
    assert_equal 6, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = Invoice.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 5, result.size
  end

end
