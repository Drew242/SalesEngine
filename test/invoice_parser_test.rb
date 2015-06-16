require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_parser'


class InvoiceParserTest < Minitest::Test

  def test_it_can_recieve_data
    parser = InvoiceParser.new("repo")
    parser.convert({id: "43"})
    assert_equal "43", parser.get_id
  end

  def test_it_can_assign_correct_data
    data = {merchant_id: "55"}
    parser = InvoiceParser.new("repo")
    parser.convert(data)
    assert_equal "55", parser.get_merchant_id
  end

  def test_it_creates_an_instance_of_merchant

    data = {id: "2"}
    parser = InvoiceParser.new("repo")
    result = parser.convert(data)
    assert_equal Invoice, result.class
  end

end
