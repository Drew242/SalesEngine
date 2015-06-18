require_relative '../test/test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemsTest < Minitest::Test

  def test_it_has_an_invoice_id
    invoice = InvoiceItem.new({id:"4", invoice_id: "1",item_id:"67",merchant_id:"5",
    status:"shipped", quantity:"9", unit_price: "23",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 1, invoice.invoice_id
  end

  def test_it_has_an_id
    invoice = InvoiceItem.new({id:"4", invoice_id: "1",item_id:"67",merchant_id:"5",
    status:"shipped", quantity:"9", unit_price: "23",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal 4, invoice.id
  end

  def test_it_has_a_created_at_date
    invoice = InvoiceItem.new({id:"4", invoice_id: "1",item_id:"67",merchant_id:"5",
    status:"shipped", quantity:"9", unit_price: "23",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal "2012-03-25 09:54:09 UTC", invoice.created
  end

  def test_id_has_an_updated_at_date
    invoice = InvoiceItem.new({id:"4", invoice_id: "1",item_id:"67",merchant_id:"5",
    status:"shipped", quantity:"9", unit_price: "23",
    created_at:"2012-03-25 09:54:09 UTC",
    updated_at:"2012-03-25 09:54:09 UTC"}, "repo")
    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated
  end

end
