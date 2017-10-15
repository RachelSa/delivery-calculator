class Matcher
  def self.depo
    {"latitude": -37.816452, "longitude": 144.963826}
  end
  # 303 Collins Street, Melbourne, VIC 3000
  SPEED = 50 # km/hr

  def run
    a = Adapter.new
    @drones = a.make_drones
    @packages = a.make_packages
    @sortedDrones = @drones.sort {|a,b| a.distance_before_new_assignment <=> b.distance_before_new_assignment}
    # first is closest drone
    @sortedPackages = @packages.sort {|a,b| a.deadline <=> b.deadline} # first is smallest deadline
  
  end

  def package_matches
  #  @packages.each {|package| package.find_matches(@drones)}
  end

  # for each pacakge, get its drone matches with time to delivery.
  def self.calc_distance(a,b)
    rad_per_deg = Math::PI/180

    dlat_rad = (a["latitude"]-b["latitude"]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (a["longitude"]-b["longitude"]) * rad_per_deg

    lat1_rad = a["latitude"] * rad_per_deg
    lon1_rad = a["longitude"] * rad_per_deg
    lat2_rad = b["latitude"] * rad_per_deg
    lon2_rad = b["longitude"] * rad_per_deg

    d = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(d), Math::sqrt(1-d))

    6371 * c # Earth's radius in km * c = Delta in meters
  end

end
