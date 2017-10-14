class Matcher

  DEPO = {latitude: -37.816452, longitude: 144.963826}
  # 303 Collins Street, Melbourne, VIC 3000

  def initialize
    a = Adapter.new
    @drones = a.make_drones
    @packages = a.make_packages

  end



end
