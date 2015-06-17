require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_parser'


class ItemParserTest < Minitest::Test

  def test_it_can_recieve_data
    parser = ItemParser.new("repo")
    parser.convert({name: "Item Qui Esse"})
    assert_equal "Item Qui Esse", parser.get_name
  end

  def test_it_can_assign_correct_data
    data = {name: "Item Qui Esse"}
    parser = ItemParser.new("repo")
    parser.convert(data)
    assert_equal "Item Qui Esse", parser.get_name
  end

  def test_it_creates_an_instance_of_an_item
    data = {name: "Item Qui Esse"}
    parser = ItemParser.new("repo")
    result = parser.convert(data)
    assert_equal Items, result.class
  end

end
