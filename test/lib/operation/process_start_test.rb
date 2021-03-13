require 'test_helper'

class Operation::ProcessStartTest < Minitest::Test
  def test_event
    event = Operation::ProcessStart.new(path: 'uname', arguments: '-a').invoke
    assert_equal 'ProcessStart', event.activity_type

    assert event.timestamp
    assert_equal Process.euid, event.username
    assert_equal 'uname -a', event.process_cmd
    assert event.process_id
  end
end
