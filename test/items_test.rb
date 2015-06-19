require_relative '../test/test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_it_has_a_name
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "Item_que", item.name
  end

  def test_it_has_an_id
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal 2, item.id
  end

  def test_it_has_a_description
    item = Item.new({id:"2", name:"Item_que", description:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "something", item.description
  end

  def test_it_has_a_unit_price
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"1", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "1", item.price
  end

  def test_it_has_a_merchant_id
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal 7, item.merchant_id
  end

  def test_it_has_a_created_at_date
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "date1", item.created
  end

  def test_id_has_an_updated_at_date
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "date2", item.updated
  end

  def test_it_can_move_instances_up_to_its_repo_for_an_invoice
    repo = Minitest::Mock.new
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, repo)
    repo.expect(:find_invoice_items_by_item_id, [], [item.id])
    item.invoice_items
    repo.verify
  end

  def test_it_can_move_instances_up_to_its_repo_for_merchant
    repo = Minitest::Mock.new
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"date1", updated_at:"date2"}, repo)
    repo.expect(:find_merchant_by_merchant_id, [], [item.merchant_id])
    item.merchant
    repo.verify
  end

end
