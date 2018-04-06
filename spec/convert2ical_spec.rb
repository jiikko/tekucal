require 'spec_helper'
require 'date'

describe Tekucal::Convert2Ical do
  describe '.set_datetimes' do
    it '日付を返すこと' do
      dates = Tekucal::Event::Struct.parse_datetimes('4/7 (土) 15:00〜19:00')
      year = Date.today.year
      expect(dates.first).to eq(Time.new(year, 4, 7, 15, 00, 00))
      expect(dates.last).to eq(Time.new(year, 4, 7, 19, 00, 00))
      dates = Tekucal::Event::Struct.parse_datetimes('4/1 (日)21:00~21:30,モニタリング')
      expect(dates.first).to eq(Time.new(year, 4, 1, 21, 00, 00))
      expect(dates.last).to eq(Time.new(year, 4, 1, 21, 30, 00))
    end
  end
  it 'tes t' do
    skip
    line = '4/7 (土)15:00〜19:00,シフト'
    converter = Tekucal::Convert2Ical.new
    expect(converter.line_convert(line)).to eq(<<~EOH)
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
