//
//  String+Extension.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 05/01/2021.
//

import Foundation
import MapKit


extension String{
    func getTimeFromRoute(route:MKRoute)->String{
        var timeString = ""
               if route.expectedTravelTime > 3600 {
                   let h = Int(route.expectedTravelTime / 60 / 60)
                   let m = Int((route.expectedTravelTime.truncatingRemainder(dividingBy: 60 * 60)) / 60)
                   timeString = String(format: "%d hr %d min", h, m)
               } else {
                   let time = Int(route.expectedTravelTime / 60)
                   timeString = String(format: "%d min", time)
               }
        return timeString
    }
}
