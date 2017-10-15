require 'byebug'

class Drone
  attr_reader :droneId, :location
  attr_accessor :packages

  def initialize(params)
    params.each do |key, value|
      if key != "packages"
        instance_variable_set("@#{key}", value)
      else
        packages = value.map {|package| Package.new(package) }
        @packages = packages
      end
    end
  end

  def distance_before_new_assignment
    # for all packages, find distance to travel to destinations, as well as back to depo
     distance = packages.inject(0) do |sum, package|
       dest = sum + Matcher.calc_distance(package.destination, location)
      dest + Matcher.calc_distance(package.destination, {"latitude"=>-37.816452, "longitude"=>144.963826})
     end
      distance == 0 ? Matcher.calc_distance(location, {"latitude"=>-37.816452, "longitude"=>144.963826}) : distance
  end



end
