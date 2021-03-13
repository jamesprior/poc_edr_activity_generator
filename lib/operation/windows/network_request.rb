module Operation
  module Windows
    class NetworkRequest
      def invoke
        raise 'TODO: windows specific network requests'
        event.network_dst_host = 'todo'
        event.network_dst_port = 'todo'
        event.network_src_host = 'todo'
        event.network_src_port = 'todo'
        event.network_data_sent = 'todo'
        event.network_protocol = 'todo'

        event
      end
    end
  end
end