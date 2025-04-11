//
//  CLLocationCoordinate2D+Extension.swift
//  Core
//
//  Created by Luis Marca on 11/04/25.
//

import CoreLocation

public extension CLLocationCoordinate2D {
    
    static func randomCoordinateInPeru() -> CLLocationCoordinate2D {
        let minLatitude: Double = -12.1
        let maxLatitude: Double = -11.8
        let minLongitude: Double = -77.3
        let maxLongitude: Double = -76.8


        let randomLatitude = Double.random(in: minLatitude...maxLatitude)
        let randomLongitude = Double.random(in: minLongitude...maxLongitude)

        return CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
    }
}
