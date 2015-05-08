require 'spec_helper'

describe Ziptz do
  describe '#time_zone' do
    let(:ziptz) { Ziptz.new }

    context 'when given a 5-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone('97034')).to eq '8'
      end
    end

    context 'when there is no matching zipcode' do
      it 'returns nil' do
        expect(ziptz.time_zone('xyz')).to be_nil
      end
    end
  end

  describe '#zips' do
    context 'when given a time zone' do
      let(:ziptz) { Ziptz.new }

      it 'returns an array of zip codes' do
        expect(ziptz.zips('11')).to eq %w(96799 96941 96942 96943 96944)
      end
    end
  end
end
