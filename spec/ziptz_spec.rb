require 'spec_helper'

RSpec.describe Ziptz do
  let(:db_path) { File.join(File.dirname(__FILE__), 'fixtures', 'tz.db') }
  let(:ziptz) { described_class.new(db_path) }

  describe 'when inspected' do
    it 'does not show internal instance variables' do
      expect(ziptz.inspect).to match(/#<Ziptz:\d+>/)
    end
  end

  describe '#time_zone_name' do
    context 'when given a 5-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_name('97034')).to eq 'America/Los_Angeles'
      end
    end

    context 'when given a 9-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_name('97034-1234')).to eq 'America/Los_Angeles'
      end
    end

    context 'when there is no matching zipcode' do
      it 'returns nil' do
        expect(ziptz.time_zone_name('xyz')).to be_nil
      end
    end

    context 'when nil is passed' do
      it 'returns nil' do
        expect(ziptz.time_zone_name(nil)).to be_nil
      end
    end
  end

  describe '#time_zone_uses_dst?' do
    context 'when given a valid 5-digit zipcode' do
      it 'returns true' do
        expect(ziptz.time_zone_uses_dst?('97034')).to eq true
      end
    end

    context 'when given an invalid 5-digit zipcode' do
      it 'returns false' do
        expect(ziptz.time_zone_uses_dst?('85004')).to eq false
      end
    end

    context 'when given a valid 9-digit zipcode' do
      it 'returns a true' do
        expect(ziptz.time_zone_uses_dst?('97034-1234')).to eq true
      end
    end

    context 'when given an invalid 9-digit zipcode' do
      it 'returns false' do
        expect(ziptz.time_zone_uses_dst?('85004-1234')).to eq false
      end
    end

    context 'when there is no matching zipcode' do
      it 'returns nil' do
        expect(ziptz.time_zone_uses_dst?('xyz')).to be_nil
      end
    end
  end

  describe '#time_zone_offset' do
    context 'when given a 5-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_offset('97034')).to eq(-28_800)
      end
    end

    context 'when given a 9-digit zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_offset('97034-1234')).to eq(-28_800)
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
      it 'returns an array of zip codes' do
        expect(ziptz.zips('Pacific/Pago_Pago')).to eq %w[96799]
      end

      it 'is case-insensitive' do
        expect(ziptz.zips('pacific/pago_pago')).to eq %w[96799]
      end

      it 'returns empty array for unknown time zones' do
        expect(ziptz.zips('Glark')).to be_empty
      end
    end
  end

  describe 'initialization' do
    it 'accepts database path as first argument' do
      expect { described_class.new(db_path) }.to_not raise_error
    end

    it 'accepts database path as keyword argument' do
      expect { described_class.new(db: db_path) }.to_not raise_error
    end

    it 'raises an error when database path is nil' do
      expect { described_class.new }.to raise_error(ArgumentError, 'Database path is required')
      expect { described_class.new(db: nil) }.to raise_error(ArgumentError, 'Database path is required')
    end

    it 'raises an error when database path is empty' do
      expect { described_class.new('') }.to raise_error(ArgumentError, 'Database path is required')
      expect { described_class.new(db: '') }.to raise_error(ArgumentError, 'Database path is required')
    end

    it 'raises an error when database file does not exist' do
      expect { described_class.new('nonexistent.db') }.to raise_error(ArgumentError, 'Database file does not exist')
      expect { described_class.new(db: 'nonexistent.db') }.to raise_error(ArgumentError, 'Database file does not exist')
    end
  end
end
