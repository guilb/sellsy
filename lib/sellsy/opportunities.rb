require 'multi_json'

module Sellsy
  #class Opportunity
  #  attr_accessor :id
  #  attr_accessor :name, :type, :joindate, :email

  #   def create
  #     command = {
  #         'method' => 'Client.create',
  #         'params' => {
  #             'third' => {
  #                 'name'			=> @name,
  #                 'joindate'	    => @joindate,
  #                 'type'			=> @type,
  #                 'email'			=> @email
  #             }
  #         }
  #     }

  #     response = MultiJson.load(Sellsy::Api.request command)

  #     @id = response['response']['client_id'] if response['response']

  #     return response['status'] == 'success'
  #   end

  #   def update

  #   end
  # end

  class Opportunities
    # def self.find(id)
    #   command = {
    #       'method' => 'Client.getOne',
    #       'params' => {
    #           'clientid' => id
    #       }
    #   }

    #   response = MultiJson.load(Sellsy::Api.request command)

    #   client = Client.new

    #   if response['response']
    #     value = response['response']['client']
    #     client.id = value['id']
    #     client.name = value['name']
    #     client.joindate = value['joindate']
    #     client.type = value['type']
    #   end

    #   return client
    # end

    def self.search(query)
      command = {
          'method' => 'Opportunities.getList',
          'params' => params
      }

      opportunities = []
      if response['response']
        response['response']['result'].each do |key, value|
          opportunity = Opportunity.new
          opportunity.id = key
          opportunity.sellsy_status = value['status']
          opportunity.sellsy_name = value['name']
          opportunity.sellsy_ident = value['ident']
          opportunity.sellsy_signed = value['signed']
          opportunities << opportunity
        end
      end

      return opportunities

    def self.all
      command = {
        'method' => 'Opportunities.getList',
        'params' => {}
      }

      response = MultiJson.load(Sellsy::Api.request command)

      opportunities = []
      if response['response']
        response['response']['result'].each do |key, value|
          opportunity = Opportunity.new
          opportunity.id = key
          opportunity.sellsy_status = value['status']
          opportunity.sellsy_name = value['name']
          opportunity.sellsy_ident = value['ident']
          opportunity.sellsy_signed = value['signed']
          opportunities << opportunity
        end
      end

      return opportunities
    end
  end
end
