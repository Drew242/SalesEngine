require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_items_parser'


class InvoiceParserTest < Minitest::Test

  def test_it_can_recieve_data
    parser = InvoiceItemsParser.new("repo")
    parser.convert({id: "43"})
    assert_equal "43", parser.get_id
  end

  def test_it_can_assign_correct_data
    data = {invoice_id: "55"}
    parser = InvoiceItemsParser.new("repo")
    parser.convert(data)
    assert_equal "55", parser.get_invoice_id
  end

  def test_it_creates_an_instance_of_an_invoice

    data = {id: "2"}
    parser = InvoiceItemsParser.new("repo")
    result = parser.convert(data)
    assert_equal InvoiceItem, result.class
  end

end
