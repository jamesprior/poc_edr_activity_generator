require 'test_helper'

class Operation::DeleteFileTest < Minitest::Test
  def test_event
    path = File.expand_path('./tmp/test.txt')
    FileUtils.touch(path)

    event = Operation::DeleteFile.new(path: path).invoke
    assert_equal 'DeleteFile', event.activity_type

    assert event.timestamp
    assert event.full_path
    assert_equal Process.euid, event.username
    assert event.process_id
  end
end