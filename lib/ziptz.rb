require 'sqlite3'
require 'version'

class Ziptz
  def initialize(*args, db: nil)
    @db_path = args[0] || db
    raise ArgumentError, 'Database path is required' if @db_path.nil? || @db_path.empty?
    raise ArgumentError, 'Database file does not exist' unless File.exist?(@db_path)
  end

  def db
    Thread.current[:ziptz_db] ||= begin
      db = SQLite3::Database.open(@db_path)
      db.results_as_hash = true
      db
    end
  end

  def time_zone_name(zip)
    time_zone_info(zip)&.dig('time_zone')
  end

  def time_zone_offset(zip)
    time_zone_info(zip)&.dig('offset')
  end

  def time_zone_uses_dst?(zip)
    tz_info = time_zone_info(zip)
    return unless tz_info

    tz_info['observes_dst'] == 1
  end

  def zips(tz_name)
    sql = <<-SQL
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

  protected

  def time_zone_info(zip)
    return unless zip

    db.get_first_row('select * from zip_codes where zip_code = ? limit 1', zip[0, 5])
  end
end
