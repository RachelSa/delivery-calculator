class Package
  attr_reader :destination, :packageId, :deadline
  
  def initialize(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

end
