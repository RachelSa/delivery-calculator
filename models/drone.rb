require 'byebug'

class Drone
  attr_reader :droneId, :location
  attr_accessor :packages

  def initialize(params)
    params.each do |key, value|
      if key == "packages"
        @packages = value.map! {|package| Package.new(package) }
      else
        instance_variable_set("@#{key}", value)
      end
    end
  end

  def distance_before_new_assignment
     package = @packages[0]
     if package
       distance = GeoCalculator.new(package.destination, location).calc_distance + GeoCalculator.new(package.destination).calc_distance
       remaining = @packages[1..-1].inject(0){|sum, package| sum + GeoCalculator.new(package.destination).calc_distance * 2}
       distance += remaining
    else
      GeoCalculator.new(location).calc_distance
    end
  end

  def min_completion_time(new_package_distance)
    time = Time.now.to_i + (distance_before_new_assignment / 50) * 3600 # time in seconds
    time + (new_package_distance / 50) * 3600
  end

end
