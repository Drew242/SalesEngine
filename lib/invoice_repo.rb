require_relative '../lib/list_and_search_methods'
require_relative '../lib/invoice'
require 'bigdecimal'
class InvoiceRepository
  include ListSearch

  attr_reader :data, :sales_engine, :instances

  def initialize(data, sales_engine)
    @data         = data
    @sales_engine = sales_engine
    @instances    = manage
  end

  def manage
    return data.map do |line|
      Invoice.new(line, self)
    end
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end

  def find_by_status(status)
    instances.select do |instance|
      if instance.status.downcase.include?(status.downcase)
        return instance
      end
    end
    return nil
  end

  def find_all_by_status(status)
    total = []
    instances.select do |instance|
      if instance.status.downcase.include?(status.downcase)
        total << instance
      end
    end
    return total
  end

  def find_by_customer_id(id)
    instances.select do |instance|
      if instance.customer_id == id
        return instance
      end
    end
    return nil
  end

  def find_all_by_customer_id(id)
    invoices = []
    instances.select do |instance|
      if instance.customer_id == id
        invoices << instance
      end
    end
    invoices
  end

  def find_all_invoice_items_by_invoice_id(id)
    @sales_engine.find_all_invoice_items_by_invoice_id(id)
  end

  def find_all_transactions_by_invoice_id(id)
    @sales_engine.find_all_transactions_by_invoice_id(id)
  end

  def find_all_items_by_invoice_id(id)
    @sales_engine.find_all_items_by_invoice_id(id)
  end

  def find_a_customer_by_invoice_id(id)
    @sales_engine.find_a_customer_by_invoice_id(id)
  end

  def find_a_merchant_by_merchant_id(id)
    @sales_engine.find_merchant_by_merchant_id(id)
  end

  def create(new_invoice)
    customer     = new_invoice[:customer]
    merchant     = new_invoice[:merchant]
    status       = new_invoice[:status]
    invoice_id   = @instances.last.id + 1
    created_at   = Time.new.to_s
    updated_at   = Time.new.to_s
    items        = new_invoice[:items]
    invoice      = parse_invoice(customer, merchant, status, invoice_id, created_at, updated_at)
    @instances << invoice
    create_invoice_items(items, invoice_id)
    invoice
  end

  def parse_invoice(customer, merchant, status, invoice_id, created_at, updated_at)
    Invoice.new({customer_id: customer.id,
                merchant_id: merchant.id,
                status: status,
                id: invoice_id,
                created_at: created_at,
                updated_at: updated_at}, self)

    end

  def create_invoice_items(items, invoice_id)
    ii_repo = sales_engine.invoice_item_repository
    quantity = items.size
    counter = 1
    ii = items.map do |item|
      id =  ii_repo.instances.size + counter
      counter += 1
      create_invoice_item_hash(item, invoice_id, quantity, id)
    end
    push_to_invoice_items(ii, ii_repo)

  end

  def create_invoice_item_hash(item, invoice_id, quantity, id)
    price = item.price
    {id: id , item_id: item.id, invoice_id: invoice_id, quantity: quantity,
      unit_price: price.to_s, created_at: Time.new.to_s, updated_at: Time.new.to_s}
  end

  def push_to_invoice_items(invoice_items, ii_repo)
    invoice_items.each do |invoice_item|
      ii_repo.instances << ii_repo.create_new_item_invoice(invoice_item)
    end
  end


end
