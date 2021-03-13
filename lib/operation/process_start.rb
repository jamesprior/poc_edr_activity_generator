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
      read_pipe, write_pipe = IO.pipe
      full_cmd = "#{path} #{arguments}"
      event.process_cmd = full_cmd

      event.timestamp = Time.now.usec
      pid = Process.spawn(full_cmd, :out => write_pipe, :err => [:child, :out])
      event.process_id = pid
      Process.detach(pid)

      event
    ensure
      read_pipe.close
      write_pipe.close
    end
  end
end