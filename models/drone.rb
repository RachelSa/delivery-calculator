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

end
