require 'test_helper'

class EventTest < Minitest::Test
  def test_to_json
    assert_equal String, Event.new.to_json.class
  end
end