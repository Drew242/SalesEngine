require 'minitest/autorun'
require 'csv'
require 'minitest/pride'
require './lib/invoice_repo'
require 'file_reader'

class InvoiceRepoTest < Minitest::Test


  def test_it_can_hold_a_new_invoice
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    refute invoices.empty?
  end

  def test_it_can_return_correct_size
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.all
    assert_equal  8 , result.size

  end

  def test_it_returns_all_invoices
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.all
    result.map do |invoice|
      assert_equal Invoice, invoice.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    random = repo.random
    invoices.delete(random)
    refute invoices.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_id("2")
    assert_equal "1", result.customer_id
  end

  def test_it_can_find_an_instance_based_off_of_merchant_id
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_merchant_id("2")
    assert_equal "1", result.customer_id
  end

  def test_it_can_find_an_instance_based_off_of_customer_id
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_customer_id("1")
    assert_equal "26", result.merchant_id
  end

  def test_it_can_find_an_instance_based_off_of_status
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_status("ShiPped")
    assert_equal "1", result.customer_id
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal "1", result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_by_updated_at("2012-03-12 05:54:09 UTC")
    assert_equal "2", result.id
  end


  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_all_by_id("2")
    assert_equal "1", result[0].customer_id

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_all_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 2, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read("./test/invoice_fixture.csv")
    repo = InvoiceRepository.new(data, "sales_engine")
    invoices = repo.manage
    result = repo.find_all_by_updated_at("2012-03-12 05:54:09 UTC")
    assert_equal 2, result.size
  end

end
