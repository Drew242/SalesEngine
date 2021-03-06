require_relative '../test/test_helper'
require_relative '../lib/transaction'

class TransactionsTest < Minitest::Test
  def test_it_has_an_id
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"2012-03-25 09:54:09 UTC", updated_at:"2012-03-26 09:54:09 UTC"}, "repo")
    assert_equal 42, transaction.id
  end

  def test_it_has_an_invoice_id
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"2012-03-25 09:54:09 UTC", updated_at:"2012-03-26 09:54:09 UTC"}, "repo")
    assert_equal 2, transaction.invoice_id
  end

  def test_it_has_a_created_at_date
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"2012-03-25 09:54:09 UTC", updated_at:"2012-03-26 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-25 09:54:09 UTC"), transaction.created
  end

  def test_id_has_an_updated_at_date
    transaction = Transaction.new({id:"42", invoice_id:"2",
                                  credit_card_number:"4654405418249632",
                                  credit_card_expiration_data:"" ,result:"success",
                                   created_at:"2012-03-25 09:54:09 UTC", updated_at:"2012-03-26 09:54:09 UTC"}, "repo")
    assert_equal Date.parse("2012-03-26 09:54:09 UTC"), transaction.updated
  end

  def test_it_can_move_instances_up_to_its_repository_for_invoice_method
    repo = Minitest::Mock.new
    transaction = Transaction.new({id:"42", invoice_id:"2",
                            credit_card_number:"4654405418249632",
                            credit_card_expiration_data:"" ,result:"success",
                            created_at:"2012-03-25 09:54:09 UTC", updated_at:"2012-03-26 09:54:09 UTC"}, repo)
    repo.expect(:find_an_invoice_by_invoice_id, [], [transaction.invoice_id])
    transaction.invoice
    repo.verify
  end


end
