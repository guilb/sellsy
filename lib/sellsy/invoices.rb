require 'multi_json'

module Sellsy
  class Invoice
    attr_accessor :id
    attr_accessor :client_id
    attr_accessor :packaging_name
    attr_accessor :shipping_name
    attr_accessor :amount
    attr_accessor :unit_amount
    attr_accessor :tax_rate

    def create(invoice)
      command = {
          'method' => 'Document.create',
          'params' => {
              'document' => {
                  'doctype' => 'invoice',
                  # 'parentId' => 'parentId',
                  'thirdid' => invoice.client_id
                  # 'displayedDate' => 'displayedDate',
                  # 'subject' => 'document_subject',
                  # 'notes' => 'document_notes',
                  # 'tags' => 'document_tags',
                  # 'displayShipAddress' => 'displayshippaddress_enum',
                  # 'rateCategory' => 'rateCategory',
                  # 'globalDiscount' => 'globalDiscount',
                  # 'globalDiscountUnit' => 'globalDiscountUnit',
                  # 'hasDoubleVat' => 'hasDoubleVat',
                  # 'currency' => 'currency',
                  # 'doclayout' => 'doclayout',
                  # 'payMediums' => 'payMediums'
              },
              # 'paydate' => {
              # 'id' => 'paydate_id',
              # 'xdays' => 'paydate_xdays',
              # 'endmonth' => 'paydate_endmonth',
              # 'scaledDetails' => 'paydate_scaledDetails',
              # 'custom' => 'paydate_custom'
              # },
              # 'thirdaddress' => {
              #     'id' => 'thirdaddress_id'
              # },
              # 'shipaddress' => {
              #     'id' => 'shipaddress_id'
              # },
              'row' => {
                  '1' => {
                      'row_type' => 'packaging',
                      'row_packaging' => invoice.packaging_name,
                      'row_name' => 'row_name',
                      'row_unitAmount' => invoice.unit_amount,
                      'row_tax' => invoice.tax_rate
                      # 'row_taxid' => 'row_taxid',
                      # 'row_tax2id' => 'row_tax2id',
                      # 'row_qt' => 'row_quantity',
                      # 'row_isOption' => 'row_option',
                      # 'row_discount' => 'row_discount',
                      # 'row_discountUnit' => 'row_discountUnit'
                  },
                  '2' => {
                      'row_type' => 'shipping',
                      'row_shipping' => invoice.shipping_name,
                      # 'row_name' => 'row_name',
                      'row_unitAmount' => invoice.unit_amount,
                      'row_tax' => invoice.tax_rate,
                      # 'row_taxid' => 'row_taxid',
                      'row_tax2id' => invoice.quantity
                      # 'row_qt' => 'row_quantity',
                      # 'row_isOption' => 'row_option',
                      # 'row_discount' => 'row_discount',
                      # 'row_discountUnit' => 'row_discountUnit'
                  }
                  # '3' => {
                  # 'row_type' => 'item',
                  # 'row_linkedid' => 'catalogue_id_link',
                  # 'row_declid' => 'catalogue_declid_link',
                  # 'row_name' => 'row_name',
                  # 'row_notes' => 'row_notes',
                  # 'row_unit' => 'row_unit',
                  # 'row_unitAmount' => 'row_unit_amount',
                  # 'row_tax' => 'row_taxrate',
                  # 'row_taxid' => 'row_taxid',
                  # 'row_tax2id' => 'row_tax2id',
                  # 'row_qt' => 'row_quantity',
                  # 'row_isOption' => 'row_option',
                  # 'row_purchaseAmount' => 'row_purchaseAmount',
                  # 'row_discount' => 'row_discount',
                  # 'row_discountUnit' => 'row_discountUnit'
                  # },
                  # '4' => {
                  # 'row_type' => 'once',
                  # 'row_name' => 'row_name',
                  # 'row_notes' => 'row_notes',
                  # 'row_unit' => 'row_unit',
                  # 'row_unitAmount' => 'row_unit_amount',
                  # 'row_tax' => 'row_taxrate',
                  # 'row_taxid' => 'row_taxid',
                  # 'row_tax2id' => 'row_tax2id',
                  # 'row_qt' => 'row_quantity',
                  # 'row_isOption' => 'row_option',
                  # 'row_discount' => 'row_discount',
                  # 'row_discountUnit' => 'row_discountUnit'
                  # }
              }
          }
      }

      Sellsy::Api.request command
    end

    def update

    end
  end

  class Invoices
    def self.all
      command = {
          'method' => 'Document.getList',
          'params' => {
              'doctype' => 'invoice'
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      invoices = []

      response['response']['result'].each do |key, value|
        invoice = Invoice.new
        invoice.id = value['id']
        invoice.amount = value['rowsAmount']
        invoices << invoice
      end

      return invoices
    end
  end
end
