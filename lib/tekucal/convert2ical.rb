module Tekucal
  class Convert2Ical
    def run
      data = convert_with_header(SCHEDULE_FILE)
      File.write(ICAL_FILE, data)
      true
    end

    def line_convert(line, now = nil)
      Event::Struct.new(line, now).to_s
    end

    def convert(file)
      File.open(file).each_line.map { |line|
        Event::Struct.new(line).to_s
      }.join
    end

    def convert_with_header(file)
      <<~EOH
BEGIN:VCALENDAR
PRODID:-//Google Inc//Google Calendar 70.9054//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:PUBLISH
X-WR-CALNAME:インポート用カレンダー
X-WR-TIMEZONE:Asia/Tokyo
#{convert(file)}
END:VCALENDAR
      EOH
    end
  end
end
