require 'spec_helper'
require 'date'
require 'tempfile'

describe Tekucal::Convert2Ical do
  describe '.parse_datetimes' do
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

  describe '#convert' do
    it 'be success' do
      file = Tempfile.new
      schedule = <<~EOH
4/21 (土) 15:00〜19:00,サポート
4/28 (土) 15:00〜19:00,サポート
4/1 (日)21:00~21:30,ポッキー
      EOH
      file.write(schedule) && file.seek(0)
      converter = Tekucal::Convert2Ical.new
      expect(converter.convert(file)).to be_a(String) # 手抜き
    end
  end

  describe '#line_convert' do
    it 'be success' do
      line = '4/7 (土)15:00〜19:00,シフト'
      converter = Tekucal::Convert2Ical.new
      now = Time.now
      expect(converter.line_convert(line, now)).to eq(<<~EOH)
BEGIN:VEVENT
DTSTART:20180407T150000Z
DTEND:20180407T190000Z
DTSTAMP:#{now.strftime('%Y%m%dT%H%M%SZ')}
UID:976fdc2c58c677c63e03a2389be1deb0c5ece07a@google.com
CREATED:#{now.strftime('%Y%m%dT%H%M%SZ')}
DESCRIPTION:
LAST-MODIFIED:#{now.strftime('%Y%m%dT%H%M%SZ')}
LOCATION:
SEQUENCE:0
STATUS:CONFIRMED
SUMMARY:シフト
TRANSP:OPAQUE
END:VEVENT
      EOH
    end
  end
end
