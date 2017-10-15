class Matcher
  def run
    a = Adapter.new
    @drones = a.make_drones
    @packages = a.make_packages
    if drones? && packages?
      sort_and_match
    else
      error_response
    end
  end

  def sort_and_match
    @sorted_drones = sort_drones
    @results = {assingments:[], unassignedPackageIds:[]}
    match_packages
  end

  def error_response
    if !drones?
      puts "Sorry, no drones available."
    end
    if !packages?
      puts "No packages to deliver."
    end
  end

  def drones?
    @drones.length > 0
  end

  def packages?
    @packages.length > 0
  end

  def sort_drones
    @drones.sort {|a,b| a.distance_before_new_assignment <=> b.distance_before_new_assignment}
  end

  def sort_packages
    @packages.sort {|a,b| a.deadline <=> b.deadline}
  end

  def match_packages
    drone_index = 0
    sort_packages.each do |package|
      drone = @sorted_drones[drone_index]
      if drone
        time_to_finish = drone.min_completion_time(package.depo_to_dest)
        if time_to_finish < package.deadline
          @results[:assingments] << {droneId: drone.droneId, packageId: package.packageId}
          drone_index += 1
        else
         @results[:unassignedPackageIds] << package.packageId
        end
      else
        @results[:unassignedPackageIds] << package.packageId
      end
    end
    puts @results
  end



end
