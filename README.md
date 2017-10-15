# running the application
 ```bundle install
    ruby run.rb```

![command line gif](https://media.giphy.com/media/3o7aD29j5SjqWDHJyU/giphy.gif)

# my implemented solution
  For my solution, I used Ruby to create a package and drone matching app.

  There's no front-end interface of my application (only command line), because I envisioned this logic happening on the server-side of a larger application, such as within a Rails API. The models I created represent the packages, drones, and the logic needed to match them. These might be integrated with existing models for an application.

# models
## Adapter
  The adapter fetches drones and packages from the API and converts them into Ruby class instances.

## Drone
  The drone class structures drone data and each drone's assigned packages for delivery.

  There's also a method to calculate the distance a drone must travel (km) before any new assignments it takes on. If a drone already has assignments, the calculation includes distance to the delivery point, and then back to the depo. If a drone has multiple packages, the total distance for packages not yet in process is included. Otherwise, the total distance is simply the drone's location to the depo.

  A drones can also calculate its entire time until completion, including a new package assignment.

## Package
  The package class structures package-related data.

  A package can calculate its delivery point's distance from the depo.

## GeoCalculator
  This class holds logic related to the distance between to lat-long coordinates, using the Haversine formula. I considered using an outside API to handle this logic, but since I imagined this app as part of a larger application, I decided that there may already be an in-house solution for this need, and decided to keep my solution as simple as possible, not integrating outside APIs.  

## Matcher
  The matcher holds the logic to run the application, as well as manages all drones and packages.

  In order to match a package with a drone, I decided to first sort all packages in order of delivery time (the soonest deliveries are first). I also sorted drones. Drones with the shortest distance needed to travel before taking on a new delivery come first. Each package is paired with the first-available drone. If the package can't be delivered within deadline, it is moved to unassignedPackageIds, and the drone remains available for another match.

# drone and package matching implementation
  I chose to sort the drones and packages to ensure that impending-deadline packages were handled first, and that more available drones were accessed first. There would be significant time cost to sorting all drones and packages for a matching process if thousands of packages and drones per second were involved.

  In that case, I would move from a best-case matching system, where the most urgent packages are given to the most available drones, to one that pairs drones and packages on their time and distance being compatible, even if it's not the ideal match.

  A package could have a "depo-to-destination" time calculated, and match with any drone that has an estimated arrival time to the depo that--if added to "depo-to-destination"--would be less that the package's deadline time.  

For each package in a first-in first-out queue, drones could be searched (perhaps in reverse order from their last dispatch, or another order that favors drones more likely to be ready) until there is a drone found that is able to deliver the package on deadline.
