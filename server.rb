require 'socket'

module CloudHash
  class Server
    def initialize(port)
      @server = TCPServer.new(port)
      puts "Listening on port #{@server.local_address.ip_port}"
      @storage = {}
    end
    def start
      Socket.accept_loop(@server) do |connection|
        handle(connection)
        connection.close
      end
    end
    def handle(connection)
      loop do
        request = connection.gets
        break if request == 'exit'
        connection.puts process(request)
      end
    end
    def handle_eof(connection)
      #Read until EOF
      request = connection.read
      #Write back the result to client
      connection.write process(request)
    end
    # supported command
    # SET key value
    # GET key
    def process(request)
      command,key,value=request.split
      case command.upcase
      when 'GET'
        @storage[key]
      when 'SET'
        @storage[key]=value
      end
    end
  end
end

server=CloudHash::Server.new(4481)
server.start
