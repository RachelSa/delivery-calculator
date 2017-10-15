class Package
  attr_reader :destination, :packageId, :deadline, :matches

  def initialize(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def depo_to_dest
    GeoCalculator.new(destination).calc_distance
  end

end
