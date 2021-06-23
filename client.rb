require 'socket'
module CloudHash
  class Client
    class << self
      attr_accessor :host, :port
    end
    def initialize(host,port)
      @connection = TCPSocket.new(host,port)
    end

    def get(key)#class method
      request "GET #{key}"
    end
    def set(key,value)#class method
      request "SET #{key} #{value}"
    end
    def exit
      request "exit"
    end
    def request(string)
      @connection.puts(string)
      #Send a newline after write
      @connection.gets
      #Read until receiving a newline to get the response
    end
  end
end

client = CloudHash::Client.new('localhost',4481)
puts client.set 'prez','obama'
puts client.set 'prez','obama'
puts client.get 'prez'
puts client.get 'vp'
puts client.exit
