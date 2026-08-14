# frozen_string_literal: true

require 'sqlite3'
require_relative 'ziptz/version'

class Ziptz
  class ZipNotFound < StandardError; end

  def initialize(path = nil, db: nil)
    @db_path = path || db
    raise ArgumentError, 'Database path is required' if @db_path.nil? || @db_path.empty?
    raise ArgumentError, 'Database file does not exist' unless File.exist?(@db_path)
  end

  def db
    connections = Thread.current[:ziptz_db] ||= {}
    connections[@db_path] ||= begin
      db = SQLite3::Database.open(@db_path)
      db.results_as_hash = true
      db
    end
  end

  def close
    Thread.current[:ziptz_db]&.delete(@db_path)&.close
    nil
  end

  def time_zone_name(zip)
    time_zone_info(zip)['time_zone']
  end

  def time_zone_offset(zip)
    time_zone_info(zip)['offset']
  end

  def time_zone_uses_dst?(zip)
    time_zone_info(zip)['observes_dst'] == 1
  end

  def zips(tz_name)
    sql = <<~SQL
      select zip_code
      from zip_codes
      where time_zone = ?
      order by zip_code
    SQL
    db.execute(sql, tz_name).map { |row| row['zip_code'] }
  end

  def inspect
    "#<#{self.class}:#{object_id}>"
  end

  private

  def time_zone_info(zip)
    raise ZipNotFound, "Zip code not found: #{zip.inspect}" if zip.nil?

    zip_code = zip.is_a?(Integer) ? format('%05d', zip) : zip.to_s[0, 5]
    result = db.get_first_row('select * from zip_codes where zip_code = ? limit 1', zip_code)
    raise ZipNotFound, "Zip code not found: #{zip}" unless result

    result
  end
end
