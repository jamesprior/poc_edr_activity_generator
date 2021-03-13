require 'test_helper'

class Operation::NetworkRequestTest < Minitest::Test
  def test_event
    event = nil
    port = nil
    TCPServer.open('localhost', 0) do |serv|
      _af, port, _host, _addr = serv.addr

      event = Operation::NetworkRequest.new(host: 'localhost', port: port).invoke
      # s = serv.accept
    end

    assert_equal 'NetworkRequest', event.activity_type

    assert event.timestamp
    assert event.network_src_host
    assert event.network_src_port
    assert_equal 'localhost', event.network_dst_host
    assert_equal port, event.network_dst_port
    assert_equal 4, event.network_data_sent
    assert_equal Process.euid, event.username
    assert event.process_id
  end
end