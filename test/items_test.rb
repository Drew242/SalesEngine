require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/items'

class ItemTest < Minitest::Test
  def test_it_has_a_name
    item = Items.new(:"2", :Item_que, :something, :one, :seven, :date1, :date2, "repo")
    assert_equal :Item_que, item.name
  end

  def test_it_has_an_id
    item = Items.new(:"2", :Item_que, :something, :one, :seven, :date1, :date2, "repo")
    assert_equal :"2", item.id
  end

  def test_it_has_a_description
    item = Items.new(:"2", :Item_que, :something, :one, :seven, :date1, :date2, "repo")
    assert_equal :something, item.description
  end

  def test_it_has_a_unit_price
    item = Items.new(:"2", :Item_que, :something, :one, :seven, :date1, :date2, "repo")
    assert_equal :one, item.price
  end

  def test_it_has_a_merchant_id
    item = Items.new(:"2", :Item_que, :something, :one, :seven, :date1, :date2, "repo")
    assert_equal :seven, item.merchant_id
  end

  def test_it_has_a_created_at_date
    item = Items.new(:"2", :Item_que, :something, :one, :seven, :date1, :date2, "repo")
    assert_equal :date1, item.created
  end

  def test_id_has_an_updated_at_date
    item = Items.new(:"2", :Item_que, :something, :one, :seven, :date1, :date2, "repo")
    assert_equal :date2, item.updated
  end

end
