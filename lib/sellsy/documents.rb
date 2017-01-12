require 'multi_json'

module Sellsy
  class Document
    attr_accessor :id

    # {"status":"ok","filename":"","fileid":"0","nbpages":"1","thirdident":"","thirdname":"Alain","thirdid":"2655","thirdvatnum":"","contactId":"0","contactName":"","displayedDate":"0000-00-00","currencysymbol":"\u20ac","subject":"","docspeakerText":"Votre contact","corpaddressid":"36047","thirdaddressid":"36048","shipaddressid":"36049","rowsAmount":"0.000000000","discountPercent":"0.000000000","discountAmount":"0.000000000","rowsAmountDiscounted":"0.000000000","offerAmount":"0.000000000","rowsAmountAllInc":"0.000000000","packagingsAmount":"49.900000000","shippingsAmount":"60.000000000","totalAmountTaxesFree":"109.900000000","taxesAmountSum":"21.540400000","taxesAmountDetails":"a:1:{s:12:\"19.600000000\";s:12:\"21.540400000\";}","totalAmount":"131.440400000","payDateText":"","payDateCustom":"0000-00-00","payMediumsText":"a:1:{i:0;s:7:\"ch\u00e8que\";}","payCheckOrderText":"","payBankAccountText":"","shippingNbParcels":"0","shippingWeight":"0.000000000","shippingWeightUnit":"g","shippingVolume":"0.000000000","shippingTrackingNumber":"","shippingTrackingUrl":"","saveThirdPrefs":"N","displayShipAddress":"N","corpid":"2","ownerid":"2","linkedtype":"invoice","linkedid":"9512","created":"2012-03-21 14:30:32","prefsid":"14679","parentid":"0","docmapid":"11599","hasVat":"Y","doctypeid":"9512","step":"draft","isDeposit":"N","dueAmount":"131.440400000","currencyid":"1","currencyposition":"right","numberformat":"fr","numberdecimals":",","numberthousands":"","numberprecision":"2","formatted_dueAmount":"131,44 \u20ac","step_color":"pink","step_hex":"#C033DA","step_label":"Non envoy\u00e9e","step_css":"colorDraft","step_banner":"draft_f","step_id":"draft","displayed_payMediumsText":"ch\u00e8que","formatted_totalAmount":"131,44 \u20ac","formatted_totalAmountTaxesFree":"109,90 \u20ac","formatted_displayedDate":"04\/04\/2012","formatted_payDateCustom":"04\/04\/2012","noedit":"N"}

    def self.getlink(docid,doctype)
      command = {
          'method' => 'Document.getPublicLink_v2',
          'params' => {
               'doctype' => doctype,
        	   'docid' => docid
          }
      }
      response = MultiJson.load(Sellsy::Api.request command)

      if response['response']
        value = response['response']
        pdf = value['pdf']
      end
      return pdf
    end

    attr_accessor :id
    attr_accessor :corp_name
    attr_accessor :owner_full_name
    attr_accessor :status
    attr_accessor :identity

    attr_accessor  :total_amount_taxes_free
    attr_accessor  :taxes_amount_sum
    attr_accessor  :total_amount

    attr_accessor :client_id
    attr_accessor :packaging_name
    attr_accessor :shipping_name
    attr_accessor :amount
    attr_accessor :unit_amount
    attr_accessor :tax_rate

    # {"status":"ok","filename":"","fileid":"0","nbpages":"1","thirdident":"","thirdname":"Alain","thirdid":"2655","thirdvatnum":"","contactId":"0","contactName":"","displayedDate":"0000-00-00","currencysymbol":"\u20ac","subject":"","docspeakerText":"Votre contact","corpaddressid":"36047","thirdaddressid":"36048","shipaddressid":"36049","rowsAmount":"0.000000000","discountPercent":"0.000000000","discountAmount":"0.000000000","rowsAmountDiscounted":"0.000000000","offerAmount":"0.000000000","rowsAmountAllInc":"0.000000000","packagingsAmount":"49.900000000","shippingsAmount":"60.000000000","totalAmountTaxesFree":"109.900000000","taxesAmountSum":"21.540400000","taxesAmountDetails":"a:1:{s:12:\"19.600000000\";s:12:\"21.540400000\";}","totalAmount":"131.440400000","payDateText":"","payDateCustom":"0000-00-00","payMediumsText":"a:1:{i:0;s:7:\"ch\u00e8que\";}","payCheckOrderText":"","payBankAccountText":"","shippingNbParcels":"0","shippingWeight":"0.000000000","shippingWeightUnit":"g","shippingVolume":"0.000000000","shippingTrackingNumber":"","shippingTrackingUrl":"","saveThirdPrefs":"N","displayShipAddress":"N","corpid":"2","ownerid":"2","linkedtype":"invoice","linkedid":"9512","created":"2012-03-21 14:30:32","prefsid":"14679","parentid":"0","docmapid":"11599","hasVat":"Y","doctypeid":"9512","step":"draft","isDeposit":"N","dueAmount":"131.440400000","currencyid":"1","currencyposition":"right","numberformat":"fr","numberdecimals":",","numberthousands":"","numberprecision":"2","formatted_dueAmount":"131,44 \u20ac","step_color":"pink","step_hex":"#C033DA","step_label":"Non envoy\u00e9e","step_css":"colorDraft","step_banner":"draft_f","step_id":"draft","displayed_payMediumsText":"ch\u00e8que","formatted_totalAmount":"131,44 \u20ac","formatted_totalAmountTaxesFree":"109,90 \u20ac","formatted_displayedDate":"04\/04\/2012","formatted_payDateCustom":"04\/04\/2012","noedit":"N"}

    def create(document)
      command = {
          'method' => 'Document.create',
          'params' => {
              'document' => {
                  'doctype' => document.type,
                  # 'parentId' => 'parentId',
                  'thirdid' => document.client_id,
                  # 'displayedDate' => 'displayedDate',
                  'subject' => 'document_subject',
                  'notes' => 'document_notes',
                  # 'tags' => 'document_tags',
                  # 'displayShipAddress' => 'displayshippaddress_enum',
                  # 'rateCategory' => 'rateCategory',
                  # 'globalDiscount' => 'globalDiscount',
                  # 'globalDiscountUnit' => 'globalDiscountUnit',
                  # 'hasDoubleVat' => 'hasDoubleVat',
                  # 'currency' => 'currency',
                  'doclayout' => '52100',
                  # 'payMediums' => 'payMediums',
                  'docspeakerStaffId' => document.author
              #},
              }
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
              #'row' => document.rows
              #'row' => {}
          }
      }

		response = MultiJson.load(Sellsy::Api.request command)

		@company_id = response['response']['thirdid'] if response['response']
		puts @company_id
		return response['status'] == 'success'
    end


  end

  class Documents

  end
end

