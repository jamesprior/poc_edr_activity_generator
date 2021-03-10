require 'test_helper'

class Operation::CreateFileTest < Minitest::Test
  def test_event
    event = Operation::CreateFile.new(path: './tmp/test.txt', type: 'txt').invoke
    assert_equal 'CreateFile', event.activity_type

    assert event.timestamp
    assert event.full_path
    assert_equal Process.euid, event.username
    assert event.process_id
  end
end