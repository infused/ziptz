require 'yaml'

class Ziptz
  def initialize
    @zips = load_data
  end

  def time_zone(zip)
    @zips[zip.to_s]
  end

  def zips(tz)
    selected = @zips.select { |_, v| v == tz.to_s }
    selected.keys.sort
  end

  protected

  def data_path
    File.join(File.dirname(__FILE__), '..', 'ziptz.data')
  end

  def load_data
    zips = {}
    File.foreach(data_path) do |line|
      zip, tz = line.split('=').map { |s| s.strip }
      zips[zip] = tz
    end
    zips
  end
end
