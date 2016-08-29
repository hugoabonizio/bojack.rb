require "socket"
require "bojack/version"

module BoJack
  class Client
    attr_accessor :hostname, :port

    def initialize(hostname = "127.0.0.1", port = 5000)
      @hostname = hostname
      @port = port
      @socket = TCPSocket.new(@hostname, @port)
      # @socket.tcp_nodelay = true
    end

    def set(key, value)
      send("set #{key} #{value}")
    end

    def increment(key)
      send("increment #{key}")
    end

    def get(key)
      send("get #{key}")
    end

    def append(key, value)
      send("append #{key} #{value}")
    end

    def pop(key)
      send("pop #{key}")
    end

    def delete(key)
      send("delete #{key}")
    end

    def ping
      send("ping")
    end

    def size
      send("size")
    end

    def close
      send("close")
    end

    def send(raw)
      @socket.puts(raw)
      @socket.gets
    end
  end
end
