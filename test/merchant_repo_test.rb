require_relative '../test/test_helper'


class MerchantRepoTest < Minitest::Test
  def setup
    @file = File.expand_path("../test/fixtures/merchants.csv", __dir__)
  end

  def test_it_can_hold_a_new_merchant
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    refute repo.instances.empty?
  end

  def test_it_can_return_correct_size
    repo = MerchantRepository.new([{id: 2, name: "Joe"}, {id: 1, name: "Jim"}], "sales_engine")
    result = repo.all
    assert_equal  2 , result.size

  end

  def test_it_returns_all_merchants
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.all
    result.map do |merchant|
      assert_equal Merchant, merchant.class
    end
  end

  def test_it_can_find_random
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    random = repo.random
    merchants = repo.instances
    merchants.delete(random)
    refute merchants.include?(random)
  end

  def test_it_can_find_an_instance_based_off_of_name
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_by_name("klein, REmpel and Jones")
    assert_equal 2, result.id
  end

  def test_it_can_find_an_instance_based_off_of_id
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_by_id(2)
    assert_equal "Klein, Rempel and Jones", result.name
  end

  def test_it_can_find_an_instance_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, result.id
  end

  def test_it_can_find_an_instance_based_off_updated_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_by_updated_at("2012-03-27 16:12:25 UTC")
    assert_equal 6, result.id
  end

  def test_it_can_find_all_instances_based_off_of_first_name
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_all_by_name("williamsoN Group")
    assert_equal 2, result.size
  end


  def test_it_can_find_all_instances_based_off_of_name
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_all_by_name("klein, Rempel and Jones")
    assert_equal 1, result.count

  end

  def test_it_can_find_all_instances_based_off_of_id
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_all_by_id(2)
    assert_equal "Klein, Rempel and Jones", result[0].name

  end

  def test_it_can_find_all_instances_based_off_of_created_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 6, result.size
  end

  def test_it_can_find_all_instances_based_off_of_updated_at
    data = FileReader.new.read(@file)
    repo = MerchantRepository.new(data, "sales_engine")
    result = repo.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 5, result.size
  end

  def test_it_can_move_instances_up_to_its_sales_engine_for_items_search
    engine = Minitest::Mock.new
    repo = MerchantRepository.new([{id: 2, name: "Joe"},
      {id: 1, name: "Jim"}], engine)
      engine.expect(:find_all_items_by_merchant_id, [], [2])
      repo.find_all_items_by_merchant_id(2)
      engine.verify
    end

    def test_it_can_move_instances_up_to_its_sales_engine_for_invoices_search
      engine = Minitest::Mock.new
      repo = MerchantRepository.new([{id: 2, name: "Joe"},
        {id: 1, name: "Jim"}] , engine)
        engine.expect(:find_all_invoices_by_merchant_id, [], [2])
        repo.find_all_invoices_by_merchant_id(2)
        engine.verify
      end

      def test_it_finds_most_items_by_merchant_id
        engine     = SalesEngine.new
        data       = FileReader.new.read(@file)
        item_data  = FileReader.new.read(File.expand_path("../test/fixtures/items.csv", __dir__))
        repo       = MerchantRepository.new(data, engine)
        invoice_item_data = FileReader.new.read(File.expand_path("../test/fixtures/invoice_items.csv", __dir__))
        engine.item_repository = ItemsRepository.new(item_data, engine)
        engine.invoice_item_repository = InvoiceItemsRepository.new(invoice_item_data, engine)
        result = repo.most_items(2)
        assert_equal 1, result[1].id
      end

      def test_most_revenue_will_return_top_merchants_by_total_revenue
        reader = FileReader.new
        data                           = reader.read(@file)
        engine                         = SalesEngine.new
        repo                           = MerchantRepository.new(data, engine)
        invoice_data                   = reader.read(File.expand_path("../test/fixtures/invoices.csv", __dir__))
        engine.invoice_repository      = InvoiceRepository.new(invoice_data, engine)
        invoice_items_data             = reader.read(File.expand_path("../test/fixtures/invoice_items.csv", __dir__))
        engine.invoice_item_repository = InvoiceItemsRepository.new(invoice_items_data, engine)
        transaction_data               = reader.read(File.expand_path("../test/fixtures/transactions.csv", __dir__))
        engine.transaction_repository  = TransactionRepository.new(transaction_data, engine)
        engine.merchant_repository     = repo
        assert_equal "Schroeder-Jerde", repo.most_revenue(1)[0].name
      end

    end
