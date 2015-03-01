require 'multi_json'

module Sellsy
  class Client
    attr_accessor :id
    attr_accessor :name

    def create
      command = {
          'method' => 'Client.create',
          'params' => {
              'third' => {
                  'name'			=> @name
              }
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      return response['status'] == 'success'
    end

    def update

    end
  end

  class Clients
    def self.all
      command = {
        'method' => 'Client.getList',
        'params' => {}
      }

      response = MultiJson.load(Sellsy::Api.request command)

      clients = []
      response['response']['result'].each do |key, value|
        client = Client.new
        client.id = key
        client.name = value['fullName']
        clients << client
      end

      return clients
    end
  end
end
