
# A singular event indicating some activity that should be noticed and consumed by the EDR agent
class Event
  ATTRS = [
    :timestamp, :username, :process_name, :process_id,
    :process_cmd, :full_path, :activity_type, :network_host, :network_port,
    :network_data_sent, :network_protocol
  ].freeze

  attr_accessor *ATTRS

  def to_json(*args)
    attributes.to_json(args)
  end

  def attributes
    ATTRS.collect do |attr_name|
      [attr_name, send(attr_name)]
    end.to_h
  end
end