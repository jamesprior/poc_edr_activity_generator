module Operation
  class DeleteFile
    VALID_ATTRS = %i[path]
    attr_reader *VALID_ATTRS

    def initialize(attrs)
      @path = File.expand_path(attrs[:path])
    end

    def invoke
      event = Event.new

      event.activity_type = 'DeleteFile'
      event.full_path = path

      event.timestamp = Time.now.usec
      FileUtils.rm(path)

      event.process_id = Process.pid
      event.username = Process.euid
      event
    end
  end
end