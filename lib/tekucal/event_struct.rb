require 'digest/sha1'

module Tekucal
  module Event
    class Struct
      def self.parse_datetimes(formated_datetime)
        %r!(\d+?)/(\d+?) ?\(.\) ?(\d\d:\d\d)[~〜](\d\d:\d\d)! =~ formated_datetime
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

      def initialize(line, now = nil)
        l = line.split(',')
        datetimes = self.class.parse_datetimes(l[0])
        @start_at = datetimes[0]
        @end_at = datetimes[1]
        @title = l[1].strip
        @now = now ||= Time.now
      end

      def to_s
        <<~EOH
BEGIN:VEVENT
DTSTART:#{start_at}
DTEND:#{end_at}
DTSTAMP:#{now}
UID:#{uid}
CREATED:#{now}
DESCRIPTION:
LAST-MODIFIED:#{now}
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:#{summary}
TRANSP:OPAQUE
END:VEVENT
        EOH
      end

      def summary
        @title
      end

      def uid
        [ Digest::SHA1.hexdigest([summary, start_at.to_s].join),
          '@google.com',
        ].join
      end

      def start_at
        formatter(@start_at)
      end

      def end_at
        formatter(@end_at)
      end

      def now
        formatter(Time.now)
      end

      def formatter(time)
        time.strftime('%Y%m%dT%H%M%SZ')
      end
    end
  end
end
