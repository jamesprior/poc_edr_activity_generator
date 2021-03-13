module Operation
  class NetworkRequest
    VALID_ATTRS = %i[host port]
    attr_reader(*VALID_ATTRS)
    attr_reader :event

    def initialize(attrs)
      @host = attrs[:host]
      @port = attrs[:port]

      @event = Event.new
      event.activity_type = 'NetworkRequest'
      event.process_id = Process.pid
      event.username = Process.euid
      event.network_dst_host = @host
      event.network_dst_port = @port
      event.network_data_sent = test_data.bytesize
      event.network_protocol = 'TCP'
    end

    def invoke
      event.timestamp = Time.now.usec
      TCPSocket.open(@host, @port) do |socket|
        socket.send test_data, 0

        event.network_src_host = socket.local_address.ip_address
        event.network_src_port = socket.local_address.ip_port
      end

      event
    end

    def test_data
      'HELO'
    end
  end
end