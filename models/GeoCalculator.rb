class GeoCalculator

  DEPO = {"latitude"=>-37.816452, "longitude"=>144.963826}
  # 303 Collins Street, Melbourne, VIC 3000

  def initialize(a,b=DEPO)
    @a_lat = a["latitude"]
    @a_long = a["longitude"]
    @b_lat = b["latitude"]
    @b_long = b["longitude"]
    @rad_per_deg = Math::PI/180
  end

  def calc_distance
    dlat_rad = (@a_lat-@b_lat) * @rad_per_deg  # Delta, converted to rad
    dlon_rad = (@a_long-@b_long) * @rad_per_deg
    calc_rad
    d = Math.sin(dlat_rad/2)**2 + Math.cos(@lat1_rad) * Math.cos(@lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(d), Math::sqrt(1-d))

    6371 * c # Earth's radius in km * c = Delta in meters
  end


  def calc_rad
    @lat1_rad = @a_lat * @rad_per_deg
    @lat2_rad = @b_lat * @rad_per_deg
  end

end
