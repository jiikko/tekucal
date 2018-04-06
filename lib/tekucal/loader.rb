module Tekucal
  module Ical
    class Event
    end
  end

  class Loader
    def self.load(file)
      lines = File.read(file).split("\n")
      new(lines)
    end

    def initialize(lines)
      @header_lines = []
      @body_lines = []
      is_header = true
      lines.each do |line|
        if /BEGIN:VEVENT/ =~ line
          is_header = false
        end
        if is_header
          @header_lines << line
        else
          @body_lines << line
        end
      end
    end

    def header
      @header_lines << "END:VCALENDAR\n"
      @header_lines.join("\n")
    end

    def body
      @body_lines.join("\n").sub("END:VCALENDAR", '')
    end

    def events
      @body_lines.join("\n").scan(/(BEGIN:VEVENT.+?END:VEVENT)/m).map do |text|
        Tekucal::Ical::Event.new
      end
    end
  end
end

