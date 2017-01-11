require 'multi_json'

module Sellsy
  class Prospect
  #   attr_accessor :id
  #   attr_accessor :name, :type, :joindate, :email

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
  end

  class Prospects
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

    def self.search(params)
      command = {
          'method' => 'Prospects.getList',
          'params' => params
      }

      response = MultiJson.load(Sellsy::Api.request command)

      prospects = []
      if response['response']
        response['response']['result'].each do |key, value|
          prospect = Prospect.new
          prospect.id = key
          prospect.name = value['fullName']
          prospects << prospect
        end
      end

      return prospects
    end

    def self.all
      command = {
        'method' => 'Prospects.getList',
        'params' => {}
      }

      response = MultiJson.load(Sellsy::Api.request command)

      clients = []
      if response['response']
        response['response']['result'].each do |key, value|
          prospect = Prospect.new
          prospect.id = key
          prospect.name = value['fullName']
          prospects << prospect
        end
      end

      return prospects
    end
  end
end
