# frozen_string_literal: true

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

    context 'when given an integer zipcode' do
      it 'returns the time zone number' do
        expect(ziptz.time_zone_name(97_034)).to eq 'America/Los_Angeles'
      end

      it 'zero-pads integers to 5 digits' do
        expect(ziptz.time_zone_name(601)).to eq 'America/Puerto_Rico'
      end
    end

    context 'when there is no matching zipcode' do
      it 'raises ZipNotFound' do
        expect { ziptz.time_zone_name('xyz') }.to raise_error(Ziptz::ZipNotFound)
      end
    end

    context 'when nil is passed' do
      it 'raises ZipNotFound' do
        expect { ziptz.time_zone_name(nil) }.to raise_error(Ziptz::ZipNotFound)
      end
    end
  end

  describe '#time_zone_uses_dst?' do
    context 'when given a valid 5-digit zipcode' do
      it 'returns true' do
        expect(ziptz.time_zone_uses_dst?('97034')).to be true
      end
    end

    context 'when given an invalid 5-digit zipcode' do
      it 'returns false' do
        expect(ziptz.time_zone_uses_dst?('85004')).to be false
      end
    end

    context 'when given a valid 9-digit zipcode' do
      it 'returns a true' do
        expect(ziptz.time_zone_uses_dst?('97034-1234')).to be true
      end
    end

    context 'when given an invalid 9-digit zipcode' do
      it 'returns false' do
        expect(ziptz.time_zone_uses_dst?('85004-1234')).to be false
      end
    end

    context 'when there is no matching zipcode' do
      it 'raises ZipNotFound' do
        expect { ziptz.time_zone_uses_dst?('xyz') }.to raise_error(Ziptz::ZipNotFound)
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
      it 'raises ZipNotFound' do
        expect { ziptz.time_zone_offset('xyz') }.to raise_error(Ziptz::ZipNotFound)
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

  describe 'multiple instances on the same thread' do
    let(:other_db_path) { File.join(Dir.tmpdir, 'ziptz_other.db') }

    before do
      FileUtils.rm_f(other_db_path)
      db = SQLite3::Database.open(other_db_path)
      db.execute('create table zip_codes (zip_code text, time_zone text, offset integer, observes_dst integer)')
      db.execute("insert into zip_codes values ('00001', 'Other/Zone', 0, 0)")
      db.close
    end

    after { FileUtils.rm_f(other_db_path) }

    it 'reads from its own database rather than the first instance to connect' do
      described_class.new(db_path).time_zone_name('97034')

      other = described_class.new(other_db_path)
      expect(other.time_zone_name('00001')).to eq 'Other/Zone'
    end

    it 'does not serve rows from another instance database' do
      described_class.new(other_db_path).time_zone_name('00001')

      expect { ziptz.time_zone_name('00001') }.to raise_error(Ziptz::ZipNotFound)
    end

    it 'applies results_as_hash to every connection' do
      described_class.new(other_db_path).time_zone_name('00001')

      expect(ziptz.zips('Pacific/Pago_Pago')).to eq %w[96799]
    end
  end

  describe '#close' do
    it 'allows queries after close by reopening the connection' do
      ziptz.time_zone_name('97034')
      ziptz.close

      expect(ziptz.time_zone_name('97034')).to eq 'America/Los_Angeles'
    end

    it 'is idempotent' do
      ziptz.time_zone_name('97034')

      expect { 2.times { ziptz.close } }.to_not raise_error
    end

    it 'can be called before any connection is opened' do
      expect { described_class.new(db_path).close }.to_not raise_error
    end
  end

  describe 'initialization' do
    it 'accepts database path as first argument' do
      expect { described_class.new(db_path) }.to_not raise_error
    end

    it 'accepts database path as keyword argument' do
      expect { described_class.new(db: db_path) }.to_not raise_error
    end

    it 'raises an error when no database path is given' do
      expect { described_class.new }.to raise_error(ArgumentError, 'Database path is required')
    end

    it 'raises an error when database path keyword is nil' do
      expect { described_class.new(db: nil) }.to raise_error(ArgumentError, 'Database path is required')
    end

    it 'raises an error when database path argument is empty' do
      expect { described_class.new('') }.to raise_error(ArgumentError, 'Database path is required')
    end

    it 'raises an error when database path keyword is empty' do
      expect { described_class.new(db: '') }.to raise_error(ArgumentError, 'Database path is required')
    end

    it 'raises an error when database path argument does not exist' do
      expect { described_class.new('nonexistent.db') }.to raise_error(ArgumentError, 'Database file does not exist')
    end

    it 'raises an error when database path keyword does not exist' do
      expect { described_class.new(db: 'nonexistent.db') }.to raise_error(ArgumentError, 'Database file does not exist')
    end
  end
end
