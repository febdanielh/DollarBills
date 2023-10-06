//
//  CLLocation.swift
//  DollarBills
//
//  Created by Abiyyu Firmansyah on 05/10/23.
//

import Foundation
import CoreLocation

extension Array where Element == CLLocation {
    
    // Calculate the total distance traveled through a series of CLLocation
    var distance: Double {
        guard count > 1 else { return 0 }
        var distance = Double.zero
        
        // Iterate over all elements in the array, calculating the distance between each pair of CLLocation
        for i in 0..<count-1 {
            let location = self[i]
            let nextLocation = self[i+1]
            distance += nextLocation.distance(from: location)
        }
        return distance
    }
    
    
    // Calculate the total elevation through a series of CLLocation
    var elevation: Double {
        guard count > 1 else { return 0 }
        var elevation = Double.zero
        
        
        // Iterate over all elements in the array, calculating the elevation difference between each pair of CLLocation
        for i in 0..<count-1 {
            let location = self[i]
            let nextLocation = self[i+1]
            let delta = nextLocation.altitude - location.altitude
            if delta > 0 {
                elevation += delta
            }
        }
        return elevation
    }
}

extension CLLocationCoordinate2D {
     var location: CLLocation {
         CLLocation(latitude: latitude, longitude: longitude) // Creates a CLLocation instance from coordinates
     }
}
