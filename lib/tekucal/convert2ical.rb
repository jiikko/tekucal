module Tekucal
  class Convert2Ical
    def line_convert(line, now = nil)
      Event::Struct.new(line, now).to_s
    end

    def convert(file)
      File.open(file).each_line.map { |line|
        Event::Struct.new(line).to_s
      }.join
    end
  end
end
