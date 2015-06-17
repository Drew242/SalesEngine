require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transactions'

class TransactionsTest < Minitest::Test
  def test_it_has_an_id
    transaction = Transactions.new(:"42", :"42", :"4654405418249632",:"" ,:"success", :date1, :date2, "repo")
    assert_equal :"42", transaction.id
  end

  def test_it_has_an_invoice_id
    transaction = Transactions.new(:"42", :"42", :"4654405418249632",:"" ,:"success", :date1, :date2, "repo")
    assert_equal :"42", transaction.id
  end

  def test_it_has_a_created_at_date
    transaction = Transactions.new(:"42", :"42", :"4654405418249632",:"" ,:"success", :date1, :date2, "repo")
    assert_equal :date1, transaction.created
  end

  def test_id_has_an_updated_at_date
    transaction = Transactions.new(:"42", :"42", :"4654405418249632",:"" ,:"success", :date1, :date2, "repo")
    assert_equal :date2, transaction.updated
  end

end
