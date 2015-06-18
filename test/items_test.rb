require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_it_has_a_name
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"seven",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "Item_que", item.name
  end

  def test_it_has_an_id
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"seven",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "2", item.id
  end

  def test_it_has_a_description
    item = Item.new({id:"2", name:"Item_que", description:"something",
                    unit_price:"one", merchant_id:"seven",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "something", item.description
  end

  def test_it_has_a_unit_price
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"seven",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "one", item.price
  end

  def test_it_has_a_merchant_id
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"seven",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "seven", item.merchant_id
  end

  def test_it_has_a_created_at_date
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"seven",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "date1", item.created
  end

  def test_id_has_an_updated_at_date
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"seven",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "date2", item.updated
  end

end
