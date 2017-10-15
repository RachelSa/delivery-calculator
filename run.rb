require 'require_all'

require_all 'models'

puts "matching packages to drones..."
Matcher.new.run
puts "...done matching!"
