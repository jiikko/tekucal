module Tekucal
  module Event
    class Struct
      def self.parse_datetimes(formated_datetime)
        %r!(\d+?)/(\d+?) ?\(.\) ? (\d\d:\d\d)[~〜](\d\d:\d\d)! =~ formated_datetime
        year = Date.today.year
        month = $1
        day = $2
        start_time = $3
        time = start_time.split(':')
        start_hour = time[0]
        start_min = time[1]
        end_time = $4
        time = end_time.split(':')
        end_hour = time[0]
        end_min = time[1]
        [ Time.new(year, month, day, start_hour, start_min, 0),
          Time.new(year, month, day, end_hour, end_min, 0),
        ]
      end

      def initialize(line)
        l = line.split(',')
        set_datetimes(l[0])
        @title = l[1]
      end

      def to_s
        <<~EOH
BEGIN:VEVENT
DTSTART:20180407T010000Z
DTEND:20180407T030000Z
DTSTAMP:20180406T140049Z
UID:5@google.com
CREATED:20180406T140022Z
DESCRIPTION:
LAST-MODIFIED:20180406T140022Z
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:テストですのんほいパーク2
TRANSP:OPAQUE
END:VEVENT
        EOH
      end
    end
  end
end
