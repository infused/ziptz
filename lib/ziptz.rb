require 'yaml'

class Ziptz
  def initialize
    path = File.join(File.dirname(__FILE__), '..', 'ziptz.yml')
    @zips = YAML.load(File.read(path))
  end

  def time_zone(zip)
    @zips[zip.to_s]
  end

  def zips(tz)
    selected = @zips.select {|_, v| v == tz.to_s}
    selected.keys.sort
  end
end
