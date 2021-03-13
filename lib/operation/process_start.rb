module Operation
  class ProcessStart
    VALID_ATTRS = %i[path arguments]
    attr_reader(*VALID_ATTRS)
    attr_reader :event

    def initialize(attrs)
      @path = attrs[:path]
      @arguments = attrs[:arguments]

      @event = Event.new
      event.activity_type = 'ProcessStart'
      event.username = Process.euid
    end

    def invoke
      full_cmd = "#{path} #{arguments}"
      event.process_cmd = full_cmd
      event.timestamp = Time.now.usec
      event.process_id = spawn(full_cmd)

      event
    end
  end
end