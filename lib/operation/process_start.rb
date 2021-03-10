module Operation
  class ProcessStart
    VALID_ATTRS = %i[path arguments]
    attr_reader *VALID_ATTRS

    def initialize(attrs)
      @path = attrs[:path]
      @arguments = attrs[:arguments]
    end

    def invoke
      full_cmd = "#{path} #{arguments}"
      event = Event.new

      event.activity_type = 'ProcessStart'

      event.timestamp = Time.now.usec
      event.process_id = spawn(full_cmd)
      event.username = Process.euid
      event.process_cmd = full_cmd
      event
    end
  end
end