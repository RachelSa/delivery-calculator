require 'httparty'

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


end
