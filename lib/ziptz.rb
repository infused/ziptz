require 'yaml'

class Ziptz
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
    hash = get_time_zone_hash(zip)
    hash && hash[:name]
  end

  def time_zone_offset(zip)
    tz = get_time_zone_hash(zip)
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

  def get_time_zone_hash(zip)
    key = @zips[zip.to_s]
    TZ_INFO[key]
  end

  def tz_name_to_code
    @tz_name_to_code ||= TZ_INFO.each_with_object({}) do |(code, tz), data|
      key = tz[:name].downcase
      data[key] = code
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
