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

      @id = response['response']['client_id']

      return response['status'] == 'success'
    end

    def update

    end
  end

  class Clients
    def self.find(id)
      command = {
          'method' => 'Client.getOne',
          'params' => {
              'clientid' => id
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      value = response['response']['client']

      client = Client.new
      client.id = value['id']
      client.name = value['name']

      return client
    end

    def self.search(query)
      command = {
          'method' => 'Client.getList',
          'params' => {
              'search' => {
                  'contains' => query
              }
          }
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
