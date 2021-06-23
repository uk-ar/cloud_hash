require 'socket'
module CloudHash
  class Client
    class << self
      attr_accessor :host, :port
    end
    def initialize(host,port)
      @connection = TCPSocket.new(host,port)
    end

    def self.get(key)#class method
      request "GET #{key}"
    end
    def self.set(key,value)#class method
      request "SET #{key} #{value}"
    end
    def self.request(string)
      @client = TCPSocket.new(host,port)
      @client.write(string)
      #Send EOF after write
      @client.close_write
      #Read until EOF
      @client.read
    end
  end
end

CloudHash::Client.host = 'localhost'
CloudHash::Client.port = 4481
puts CloudHash::Client.set 'prez','obama'
puts CloudHash::Client.get 'prez'
puts CloudHash::Client.get 'vp'
