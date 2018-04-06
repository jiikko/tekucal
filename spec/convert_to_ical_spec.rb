require 'spec_helper'

describe Tekucal::ConvertToIcal do
  it 'tes t' do
    skip
    line = '4/7 (土),15:00〜19:00,シフト'
    converter = Tekucal::ConvertToIcal.new
    expect(converter.convert(line)).to eq(<<~EOH)
    gg
    EOH
  end
end
