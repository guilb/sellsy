require 'multi_json'
require 'rest_client'

module Sellsy
  class Api
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def self.authentication_header
      encoded_key = URI::escape(self.configuration.consumer_secret) + "&" + URI::escape(self.configuration.user_secret)
      now = Time.now
      oauth_params = {
          'oauth_consumer_key' => self.configuration.consumer_token,
          'oauth_token' => self.configuration.user_token,
          'oauth_nonce' => Digest::MD5.hexdigest((now.to_i + rand(0..1000)).to_s),
          'oauth_timestamp' => now.to_i.to_s,
          'oauth_signature_method' => 'PLAINTEXT',
          'oauth_version' => '1.0',
          'oauth_signature' => encoded_key
      }

      return 'OAuth ' + oauth_params.map { |k, v| k + '="' + v + '"' }.join(', ')
    end

    def self.client=(client)
      payload = {
          'method' => 'Client.create',
          'params' => {
              'third' => {
                  'name' => client.client_company.name,
                  'email' => client.client_company.email,
                  'tel' => client.client_company.landline,
                  'fax' => client.client_company.fax,
                  'siret' => client.client_company.billing_information.company_registration,
                  'vat' => client.client_company.billing_information.vat_registration
              },
              'contact' => {
                  'name' => client.last_name,
                  'forename' => client.first_name,
                  'email' => client.email,
                  'tel' => client.landline,
                  'fax' => client.fax,
                  'mobile' => client.mobile
              },
              'address' => {
                  'name' => client.address.name,
                  'part1' => client.address.street,
                  'part2' => client.address.addition,
                  'zip' => client.address.postal_code,
                  'town' => client.address.city,
                  'countrycode' => "FR"
              }
          }
      }

      self.request payload
    end

    def self.clients
      payload = {
          'method' => 'Client.getList',
          'params' => {}
      }

      self.request payload
    end

    def self.invoices=(invoice)
      payload = {
          'method' => 'Document.create',
          'params' => {
              'document' => {
                  'doctype' => 'doctype',
                  'parentId' => 'parentId',
                  'thirdid' => 'clientid',
                  'displayedDate' => 'displayedDate',
                  'subject' => 'document_subject',
                  'notes' => 'document_notes',
                  'tags' => 'document_tags',
                  'displayShipAddress' => 'displayshippaddress_enum',
                  'rateCategory' => 'rateCategory',
                  'globalDiscount' => 'globalDiscount',
                  'globalDiscountUnit' => 'globalDiscountUnit',
                  'hasDoubleVat' => 'hasDoubleVat',
                  'currency' => 'currency',
                  'doclayout' => 'doclayout',
                  'payMediums' => 'payMediums',

              },
              'paydate' => {
                  'id' => 'paydate_id',
                  'xdays' => 'paydate_xdays',
                  'endmonth' => 'paydate_endmonth',
                  'scaledDetails' => 'paydate_scaledDetails',
                  'custom' => 'paydate_custom'

              },
              'thirdaddress' => {
                  'id' => 'thirdaddress_id'
              },
              'shipaddress' => {
                  'id' => 'shipaddress_id'
              },
              'row' => {
                  '1' => {
                      'row_type' => 'packaging',
                      'row_packaging' => 'packagin_name',
                      'row_name' => 'row_name',
                      'row_unitAmount' => 'row_unit_amount',
                      'row_tax' => 'row_taxrate',
                      'row_taxid' => 'row_taxid',
                      'row_tax2id' => 'row_tax2id',
                      'row_qt' => 'row_quantity',
                      'row_isOption' => 'row_option',
                      'row_discount' => 'row_discount',
                      'row_discountUnit' => 'row_discountUnit'
                  },
                  '2' => {
                      'row_type' => 'shipping',
                      'row_shipping' => 'shipping_name',
                      'row_name' => 'row_name',
                      'row_unitAmount' => 'row_unit_amount',
                      'row_tax' => 'row_taxrate',
                      'row_taxid' => 'row_taxid',
                      'row_tax2id' => 'row_tax2id',
                      'row_qt' => 'row_quantity',
                      'row_isOption' => 'row_option',
                      'row_discount' => 'row_discount',
                      'row_discountUnit' => 'row_discountUnit'
                  },
                  '3' => {
                      'row_type' => 'item',
                      'row_linkedid' => 'catalogue_id_link',
                      'row_declid' => 'catalogue_declid_link',
                      'row_name' => 'row_name',
                      'row_notes' => 'row_notes',
                      'row_unit' => 'row_unit',
                      'row_unitAmount' => 'row_unit_amount',
                      'row_tax' => 'row_taxrate',
                      'row_taxid' => 'row_taxid',
                      'row_tax2id' => 'row_tax2id',
                      'row_qt' => 'row_quantity',
                      'row_isOption' => 'row_option',
                      'row_purchaseAmount' => 'row_purchaseAmount',
                      'row_discount' => 'row_discount',
                      'row_discountUnit' => 'row_discountUnit'
                  },
                  '4' => {
                      'row_type' => 'once',
                      'row_name' => 'row_name',
                      'row_notes' => 'row_notes',
                      'row_unit' => 'row_unit',
                      'row_unitAmount' => 'row_unit_amount',
                      'row_tax' => 'row_taxrate',
                      'row_taxid' => 'row_taxid',
                      'row_tax2id' => 'row_tax2id',
                      'row_qt' => 'row_quantity',
                      'row_isOption' => 'row_option',
                      'row_discount' => 'row_discount',
                      'row_discountUnit' => 'row_discountUnit'
                  }
              }
          }
      }
    end

    def self.info
      payload = {
          :method => 'Infos.getInfos',
          :params => {}
      }

      self.request payload
    end

    def self.request(payload)
      params = {
          'request' => 1,
          'io_mode' => 'json',
          'do_in' => payload.to_json
      }

      puts params.to_json

      RestClient.log = 'stdout'
      RestClient.post 'https://apifeed.sellsy.com/0/', {:request => 1, :io_mode => 'json', 'do_in' => payload.to_json, :multipart => true}, {:authorization => self.authentication_header}
    end

    class Configuration
      attr_accessor :consumer_secret
      attr_accessor :consumer_token
      attr_accessor :user_secret
      attr_accessor :user_token

      def initialize
      end
    end
  end

  class Invoice
    attr_accessor :client_id
    attr_accessor :packaging_name
    attr_accessor :shipping_name
    attr_accessor :unit_amount
    attr_accessor :tax_rate
  end

  class Invoices
    attr_accessor :client
    attr_accessor :estimates
    attr_accessor :invoices

    def initialize(client)
      @client = client
    end

    def <<(invoice)
      payload = {
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

      @client.request payload
    end
  end
end
