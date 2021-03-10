module Operation
  class CreateFile
    VALID_ATTRS = %i[path type]
    attr_reader *VALID_ATTRS

    def initialize(attrs)
      @path = File.expand_path(attrs[:path])
      @tyoe = attrs[:type]
    end

    def invoke
      event = Event.new

      event.activity_type = 'CreateFile'
      event.full_path = path

      event.timestamp = Time.now.usec
      FileUtils.touch(path)

      event.process_id = Process.pid
      event.username = Process.euid
      event.process_cmd = full_cmd
      event
    end
  end
end