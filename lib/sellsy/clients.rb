require 'multi_json'

module Sellsy
  class Client
    attr_accessor :id
    attr_accessor :name

    def initialize(id, name)
      @id = id
      @name = name
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
        clients << Client.new(key, value['name'])
      end

      return clients
    end
  end
end
