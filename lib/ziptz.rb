require 'yaml'

class Ziptz
  VERSION = '2.0.3'

  TZ_INFO = {
    '0'  => {name: 'APO/FPO (time zone unknown)', offset: 0},
    '4'  => {name: 'America/Puerto_Rico', offset: -4},
    '5'  => {name: 'America/New_York', offset: -5},
    '6'  => {name: 'America/Chicago', offset: -6},
    '7'  => {name: 'America/Denver', offset: -7},
    '8'  => {name: 'America/Los_Angeles', offset: -8},
    '9'  => {name: 'America/Anchorage', offset: -9},
    '10' => {name: 'America/Adak', offset: -10},
    '11' => {name: 'Pacific/Pago_Pago', offset: -11},
    '13' => {name: 'Pacific/Majuro', offset: 12},
    '14' => {name: 'Pacific/Guam', offset: 10},
    '15' => {name: 'Pacific/Palau', offset: 9},
    '16' => {name: 'Pacific/Pohnpei', offset: 11}
  }

  def time_zone_name(zip)
    hash = time_zone_info(zip)
    hash && hash[:name]
  end

  def time_zone_offset(zip)
    tz = time_zone_info(zip)
    tz && tz[:offset]
  end

  def time_zone_uses_dst?(zip)
    dst[zip.to_s]
  end

  def zips(tz_name)
    tz_code = tz_name_to_code[tz_name.downcase]
    tz_code && zips_by_code(tz_code)
  end

  def inspect
    "#<#{self.class}:#{object_id}>"
  end

  protected

  def tz
    @tz ||= load_tz_data
  end

  def dst
    @dst ||= load_dst_data
  end

  def zips_by_code(tz_code)
    tz.select { |_, v| v == tz_code.to_s }.keys.sort
  end

  def time_zone_info(zip)
    TZ_INFO[get_time_zone zip]
  end

  def get_time_zone(zip)
    tz[zip.to_s]
  end

  def tz_name_to_code
    @tz_name_to_code ||= TZ_INFO.each_with_object({}) do |(code, tz), data|
      name = tz[:name].downcase
      data[name] = code
    end
  end

  def tz_data_path
    File.join(File.dirname(__FILE__), '..', 'data', 'tz.data')
  end

  def load_tz_data
    File.foreach(tz_data_path).with_object({}) do |line, data|
      zip, tz = line.strip.split('=')
      data[zip] = tz
    end
  end

  def dst_data_path
    File.join(File.dirname(__FILE__), '..', 'data', 'dst.data')
  end

  def load_dst_data
    File.foreach(dst_data_path).with_object({}) do |line, data|
      zip, dst = line.strip.split('=')
      data[zip] = dst == '1'
    end
  end
end
