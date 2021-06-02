require 'yaml'
require 'zlib'

class Ziptz
  VERSION = '3.0.3'.freeze

  def time_zone_name(zip)
    tz_info = time_zone_info(zip)
    return unless tz_info

    tz_info[:tz]
  end

  def time_zone_offset(zip)
    tz_info = time_zone_info(zip)
    return unless tz_info

    tzm_info = tzm[tz_info[:tz]]
    tzm_info[:offset] && tzm_info[:offset].to_i
  end

  def time_zone_uses_dst?(zip)
    tz_info = time_zone_info(zip)
    return unless tz_info

    tz_info[:dst]
  end

  def zips(tz_name)
    tz.select { |_, v| v[:tz].downcase == tz_name.downcase }.keys
  end

  def inspect
    "#<#{self.class}:#{object_id}>"
  end

  protected

  def tzm
    @tzm ||= load_tzm_data
  end

  def tz
    @tz ||= load_tz_data
  end

  def time_zone_info(zip)
    tz[zip.to_s.slice(0, 5)]
  end

  def tzm_data_path
    File.join(File.dirname(__FILE__), '..', 'data', 'tzm.data')
  end

  def tz_data_path
    File.join(File.dirname(__FILE__), '..', 'data', 'tz.data')
  end

  def load_tz_data
    uncompressed = Zlib::Inflate.inflate(File.read(tz_data_path, encoding: 'ASCII-8BIT'))
    uncompressed.each_line.with_object({}) do |line, data|
      zip, tz, dst = line.strip.split(':')
      data[zip] = {tz: tz, dst: dst == '1'}
    end
  end

  def load_tzm_data
    uncompressed = Zlib::Inflate.inflate(File.read(tzm_data_path, encoding: 'ASCII-8BIT'))
    uncompressed.each_line.with_object({}) do |line, data|
      tz, offset = line.strip.split(':')
      data[tz] = {offset: offset}
    end
  end
end
