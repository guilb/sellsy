require 'multi_json'

module Sellsy
  class Document
    attr_accessor :id

    # {"status":"ok","filename":"","fileid":"0","nbpages":"1","thirdident":"","thirdname":"Alain","thirdid":"2655","thirdvatnum":"","contactId":"0","contactName":"","displayedDate":"0000-00-00","currencysymbol":"\u20ac","subject":"","docspeakerText":"Votre contact","corpaddressid":"36047","thirdaddressid":"36048","shipaddressid":"36049","rowsAmount":"0.000000000","discountPercent":"0.000000000","discountAmount":"0.000000000","rowsAmountDiscounted":"0.000000000","offerAmount":"0.000000000","rowsAmountAllInc":"0.000000000","packagingsAmount":"49.900000000","shippingsAmount":"60.000000000","totalAmountTaxesFree":"109.900000000","taxesAmountSum":"21.540400000","taxesAmountDetails":"a:1:{s:12:\"19.600000000\";s:12:\"21.540400000\";}","totalAmount":"131.440400000","payDateText":"","payDateCustom":"0000-00-00","payMediumsText":"a:1:{i:0;s:7:\"ch\u00e8que\";}","payCheckOrderText":"","payBankAccountText":"","shippingNbParcels":"0","shippingWeight":"0.000000000","shippingWeightUnit":"g","shippingVolume":"0.000000000","shippingTrackingNumber":"","shippingTrackingUrl":"","saveThirdPrefs":"N","displayShipAddress":"N","corpid":"2","ownerid":"2","linkedtype":"invoice","linkedid":"9512","created":"2012-03-21 14:30:32","prefsid":"14679","parentid":"0","docmapid":"11599","hasVat":"Y","doctypeid":"9512","step":"draft","isDeposit":"N","dueAmount":"131.440400000","currencyid":"1","currencyposition":"right","numberformat":"fr","numberdecimals":",","numberthousands":"","numberprecision":"2","formatted_dueAmount":"131,44 \u20ac","step_color":"pink","step_hex":"#C033DA","step_label":"Non envoy\u00e9e","step_css":"colorDraft","step_banner":"draft_f","step_id":"draft","displayed_payMediumsText":"ch\u00e8que","formatted_totalAmount":"131,44 \u20ac","formatted_totalAmountTaxesFree":"109,90 \u20ac","formatted_displayedDate":"04\/04\/2012","formatted_payDateCustom":"04\/04\/2012","noedit":"N"}

    def self.getlink(docid,doctype)
      command = {
          'method' => 'Documents.getPublicLink_v2',
          'params' => {
               'doctype' => doctype,
        	   'docid' => docid
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)
      #document = Document.new

      if response['response']
        value = response['response']
        pdf = value['pdf']
      end

      return pdf
    end

  end

  class Documents

  end
end

