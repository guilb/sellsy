require 'multi_json'

module Sellsy
  class Contact
    attr_accessor :id
    attr_accessor :name, :thirdid, :forename, :email, :position

    def create
      command = {
        'method' => 'Peoples.create',
        'params' => {
          'people' => {
            'name' => @name,
            'forename' => @forename,
            'email' => @email,
            'position' => @position,
            'thirdids' => [@thirdid]
          }
        }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @id = response['response']['id']

      return response['status'] == 'success'
    end

    def self.find(id)
      command = {
          'method' => 'Peoples.getOne',
          'params' => {
              'id' => id
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      value = response['response']

      contact = Contact.new
      contact.id = value['id']

      return contact
    end

    def get_addresses
      command = {
          'method' => 'Peoples.getAddresses',
          'params' => {
              'id' => id
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      value = response['response']

      client = Contact.new
      client.id = value['id']

      return client
    end
  end
end
