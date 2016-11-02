require 'yaml'

class Ziptz
  VERSION = '1.0.19'

  TZ_INFO = {
    '0'  => {name: 'APO/FPO (time zone unknown)', offset: 0},
    '4'  => {name: 'Atlantic', offset: -4},
    '5'  => {name: 'Eastern', offset: -5},
    '6'  => {name: 'Central', offset: -6},
    '7'  => {name: 'Mountain', offset: -7},
    '8'  => {name: 'Pacific', offset: -8},
    '9'  => {name: 'Alaska', offset: -9},
    '10' => {name: 'Hawaii-Aleutian Islands', offset: -10},
    '11' => {name: 'American Samoa', offset: -11},
    '13' => {name: 'Marshall Islands', offset: 12},
    '14' => {name: 'Guam', offset: 10},
    '15' => {name: 'Palau', offset: 9},
    '16' => {name: 'Micronesia', offset: 11}
  }

  def initialize
    @zips = load_data
  end

  def time_zone_name(zip)
    hash = time_zone_info(zip)
    hash && hash[:name]
  end

  def time_zone_offset(zip)
    tz = time_zone_info(zip)
    tz && tz[:offset]
  end

  def zips(tz_name)
    tz_code = tz_name_to_code[tz_name.downcase]
    tz_code && zips_by_code(tz_code)
  end

  protected

  def zips_by_code(tz_code)
    @zips.select { |_, v| v == tz_code.to_s }.keys.sort
  end

  def time_zone_info(zip)
    TZ_INFO[get_time_zone zip]
  end

  def get_time_zone(zip)
    @zips[zip.to_s]
  end

  def tz_name_to_code
    @tz_name_to_code ||= TZ_INFO.each_with_object({}) do |(code, tz), data|
      name = tz[:name].downcase
      data[name] = code
    end
  end

  def data_path
    File.join(File.dirname(__FILE__), '..', 'data', 'ziptz.data')
  end

  def load_data
    File.foreach(data_path).with_object({}) do |line, data|
      zip, tz = line.strip.split('=')
      data[zip] = tz
    end
  end
end
