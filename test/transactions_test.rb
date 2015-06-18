require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction'

class TransactionsTest < Minitest::Test
  def test_it_has_an_id
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal 42, transaction.id
  end

  def test_it_has_an_invoice_id
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal 2, transaction.invoice_id
  end

  def test_it_has_a_created_at_date
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "date1", transaction.created
  end

  def test_id_has_an_updated_at_date
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"date1", updated_at:"date2"}, "repo")
    assert_equal "date2", transaction.updated
  end

end
