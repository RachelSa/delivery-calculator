require 'httparty'
require 'byebug'

class Adapter
  def get_drones
    HTTParty.get("https://codetest.kube.getswift.co/drones")
  end

  def get_packages
    HTTParty.get("https://codetest.kube.getswift.co/packages")
  end

  def make_drones
    get_drones.map {|drone| Drone.new(drone)}
  end

  def make_packages
    get_packages.map {|package| Package.new(package)}
  end

  # def create_resources
  #   make_drones
  #   make_packages
  # end

end
