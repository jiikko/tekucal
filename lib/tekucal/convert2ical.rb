module Tekucal
  class Convert2Ical
    def line_convert(line)
      Event::Struct.new(line).to_ical
    end

    def convert(file)
      open(file).each_line do |line|
        Event::Struct.new(line)
      end
    end
  end
end
