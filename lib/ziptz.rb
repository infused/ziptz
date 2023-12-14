require 'sqlite3'
require 'version'

class Ziptz
  def self.instance
    @instance ||= new
  end

  def db
    @db ||= begin
      db = SQLite3::Database.open(tz_data_path)
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

  def tz_data_path
    File.join(File.dirname(__FILE__), '..', 'data', 'tz.db')
  end
end
