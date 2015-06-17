require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_parser'


class TransactionParserTest < Minitest::Test

  def test_it_can_recieve_data
    parser = TransactionParser.new("repo")
    parser.convert({id: "22"})
    assert_equal "22", parser.get_id
  end

  def test_it_can_assign_correct_data
    data = {invoice_id: "33"}
    parser = TransactionParser.new("repo")
    parser.convert(data)
    assert_equal "33", parser.get_invoice_id
  end

  def test_it_creates_an_instance_of_merchant
    data = {id: "44"}
    parser = TransactionParser.new("repo")
    result = parser.convert(data)
    assert_equal Transactions, result.class
  end

end
