require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_parser'


class CustomerParserTest < Minitest::Test

  def test_it_can_recieve_data
    parser = CustomerParser.new("repo")
    parser.convert({first_name: "Joey"})
    assert_equal "Joey", parser.get_first_name
  end

  def test_it_can_assign_correct_data
    data = {first_name: "Joey"}
    parser = CustomerParser.new("repo")
    parser.convert(data)
    assert_equal "Joey", parser.get_first_name
  end

  def test_it_creates_an_instance_of_customer

    data = {first_name: "Joey"}
    parser = CustomerParser.new("repo")
    result = parser.convert(data)
    assert_equal Customer, result.class
  end

end
