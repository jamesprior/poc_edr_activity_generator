module Operation
  class ModifyFile
    VALID_ATTRS = %i[path]
    attr_reader(*VALID_ATTRS)
    attr_reader :event

    def initialize(attrs)
      @path = File.expand_path(attrs[:path])

      @event = Event.new
      event.activity_type = 'ModifyFile'
      event.process_id = Process.pid
      event.username = Process.euid
    end

    def invoke
      event.full_path = path
      event.timestamp = Time.now.usec
      FileUtils.touch(path)

      event
    end
  end
end