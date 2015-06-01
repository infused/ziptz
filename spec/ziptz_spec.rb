require 'spec_helper'

describe Ziptz do
  describe '#time_zone_name' do
    let(:ziptz) { Ziptz.new }

    context 'when given a 5-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_name('97034')).to eq 'Pacific'
      end
    end

    context 'when there is no matching zipcode' do
      it 'returns nil' do
        expect(ziptz.time_zone_name('xyz')).to be_nil
      end
    end
  end

  describe '#time_zone_offset' do
    let(:ziptz) { Ziptz.new }

    context 'when given a 5-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_offset('97034')).to eq -8
      end
    end

    context 'when there is no matching zipcode' do
      it 'returns nil' do
        expect(ziptz.time_zone_offset('xyz')).to be_nil
      end
    end
  end

  describe '#zips' do
    context 'when given a time zone' do
      let(:ziptz) { Ziptz.new }

      it 'returns an array of zip codes' do
        expect(ziptz.zips('American Samoa')).to eq %w(96799 96941 96942 96943 96944)
      end

      it 'is case-insensitive' do
        expect(ziptz.zips('american samoa')).to eq %w(96799 96941 96942 96943 96944)
      end

      it 'returns nil for unknown time zones' do
        expect(ziptz.zips('Glark')).to be_nil
      end
    end
  end
end
