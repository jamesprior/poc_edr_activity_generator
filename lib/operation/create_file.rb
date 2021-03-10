module Operation
  class CreateFile
    VALID_ATTRS = %i[path file_type]
    attr_reader *VALID_ATTRS

    def initialize(attrs)
      @path = File.expand_path(attrs[:path])
      @file_type = attrs[:file_type]
    end

    def invoke
      event = Event.new

      event.activity_type = 'CreateFile'
      event.full_path = path

      event.timestamp = Time.now.usec
      FileUtils.touch(path)

      event.process_id = Process.pid
      event.username = Process.euid
      event
    end
  end
end