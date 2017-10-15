## assumptions
- packages that can't be delivered on time are unassigned
- cors
- prioritizing packages in drone-matching (# packages delivered vs time)
- calculating distance

Please also give an indication of how you envisage your solution will be deployed, and what other components it might interact with.

How did you implement your solution?
Why did you implement it this way?
Let's assume we need to handle dispatching thousands of jobs per second to thousands of drivers. Would the solution you've implemented still work? Why or why not? What would you modify? Feel free to describe a completely different solution than the one you've developed.

# my solution
  For my solution of this challenge, I used Ruby to create a package and drone matching app.

  There's no front-end interface of my application, because I envisioned this logic happening on the server-side of a larger application, such as within a Rails API. The models I created represent the packages, drones, and the logic needed to match them. These might be integrated with existing models for an application.

# models
## Adapter
  The adapter fetches drones and packages from the API and converts them into Ruby class instances.

## Drone
  The drone class holds drone data and each drone's assigned packages for delivery.

  There's also a method to calculate the distance a drone must travel (km) before any new assignments it takes on. If a drone already has assignments, the calculation includes distance to the delivery point, and then back to the depo. If a drone has multiple packages, the total distance for packages not yet in process is included. Otherwise, the distance is simply back to the depo.

  Drones can also calculate their entire time until completion, including a new package assignment.

# Package
    The package class holds package-related data.

    A package can calculate its delivery point's distance from the depo.

# GeoCalculator
    This class holds logic related to the distance between to lat-long points, using the Haversine formula. I considered using an outside API to handle this logic, but since I imagined this app as part of a larger application, I decided that there may already be an in-house solution for this need, and decided to keep my solution as simple as possible, not integrating outside APIs.  
