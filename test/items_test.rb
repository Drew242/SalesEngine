
require_relative '../test/test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_it_has_a_name
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal "Item_que", item.name
  end

  def test_it_has_an_id
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 2, item.id
  end

  def test_it_has_a_description
    item = Item.new({id:"2", name:"Item_que", description:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal "something", item.description
  end

  def test_it_has_a_unit_price
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"1234", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 12.34, item.price.to_f
  end

  def test_it_has_a_merchant_id
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 7, item.merchant_id
  end

  def test_it_has_a_created_at_date
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-04-25 09:54:09 UTC"), item.created
  end

  def test_id_has_an_updated_at_date
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), item.updated
  end

  def test_it_can_move_instances_up_to_its_repo_for_an_invoice
    repo = Minitest::Mock.new
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, repo)
    repo.expect(:find_invoice_items_by_item_id, [], [item.id])
    item.invoice_items
    repo.verify
  end

  def test_it_can_move_instances_up_to_its_repo_for_merchant
    repo = Minitest::Mock.new
    item = Item.new({id:"2", name:"Item_que", decription:"something",
                    unit_price:"one", merchant_id:"7",
                    created_at:"2012-04-25 09:54:09 UTC", updated_at:"2012-03-25 09:54:09 UTC"}, repo)
    repo.expect(:find_merchant_by_merchant_id, [], [item.merchant_id])
    item.merchant
    repo.verify
  end

  def test_best_day_returns_day_with_highest_dales
    engine = SalesEngine.new
    reader = FileReader.new
    repo   = ItemsRepository.new(reader.read(File.expand_path("../test/fixtures/items.csv", __dir__)),
                                      engine)
    engine.invoice_repository  = InvoiceRepository.new(reader.read(File.expand_path("../test/fixtures/invoices.csv", __dir__)),
                                      engine)
    engine.invoice_item_repository = InvoiceItemsRepository.new(reader.read(File.expand_path("../test/fixtures/invoice_items.csv", __dir__)),
                                      engine)
    engine.transaction_repository = TransactionRepository.new(reader.read(File.expand_path("../test/fixtures/transactions.csv", __dir__)),
                                      engine)
    engine.item_repository    = repo

    item = repo.find_by_id(4)
    assert_equal Date.parse("2012-03-24 15:54:10 UTC"), item.best_day
  end
end
