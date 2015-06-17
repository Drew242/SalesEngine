require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_parser'


class MerchantParserTest < Minitest::Test

  def test_it_can_recieve_data
    parser = MerchantParser.new("repo")
    parser.convert({name: "Jim"})
    assert_equal "Jim", parser.get_name
  end

  def test_it_can_assign_correct_data
    data = {name: "Schroeder"}
    parser = MerchantParser.new("repo")
    parser.convert(data)
    assert_equal "Schroeder", parser.get_name
  end

  def test_it_creates_an_instance_of_merchant
    data = {name: "Schroeder"}
    parser = MerchantParser.new("repo")
    result = parser.convert(data)
    assert_equal Merchant, result.class
  end

end
