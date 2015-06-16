require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def test_it_has_a_status
    invoice = Invoice.new(:"4",:"67",:"5",
    :"shipped",
    :"2012-03-25 09:54:09 UTC",
    :"2012-03-25 09:54:09 UTC", "repo")
    assert_equal :shipped, invoice.status
  end

  def test_it_has_a_customer_id

    invoice = Invoice.new(:"4",:"67",:"5",
    :"shipped",
    :"2012-03-25 09:54:09 UTC",
    :"2012-03-25 09:54:09 UTC", "repo")
    assert_equal :"67", invoice.customer_id
  end

  def test_it_has_an_id

    invoice = Invoice.new(:"4",:"67",:"5",
    :"shipped",
    :"2012-03-25 09:54:09 UTC",
    :"2012-03-25 09:54:09 UTC", "repo")
    assert_equal :"4", invoice.id
  end

  def test_it_has_a_merchant_id

    invoice = Invoice.new(:"4",:"67",:"5",
    :"shipped",
    :"2012-03-25 09:54:09 UTC",
    :"2012-03-25 09:54:09 UTC", "repo")
    assert_equal :"5", invoice.merchant_id
  end

  def test_it_has_a_created_at_date
    invoice = Invoice.new(:"4",:"67",:"5",
    :"shipped",
    :"2012-03-25 09:54:09 UTC",
    :"2012-03-25 09:54:09 UTC", "repo")
    assert_equal :"2012-03-25 09:54:09 UTC", invoice.created
  end

  def test_id_has_an_updated_at_date
    invoice = Invoice.new(:"4",:"67",:"5",
    :"shipped",
    :"2012-03-25 09:54:09 UTC",
    :"2012-03-25 09:54:09 UTC", "repo")
    assert_equal :"2012-03-25 09:54:09 UTC", invoice.updated
  end

end
