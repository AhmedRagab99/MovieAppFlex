//
//  DirectioinsEnviroment.swift
//  MovieFlexApp
//
//  Created by Ahmed Ragab on 05/01/2021.
//

import Foundation
import SwiftUI
import Combine
import MapKit

class DirectioinsEnviroment:ObservableObject{
    @Published var sourceMapItem:MKMapItem?
    @Published var destinationMapItem:MKMapItem?
    @Published var route:MKRoute?
    private var disposeBag = Set<AnyCancellable>()
    init() {
        Publishers.CombineLatest($sourceMapItem,$destinationMapItem).sink { (items) in
            
            let request = MKDirections.Request()
            request.source = items.0
            request.destination = items.1
            let directions = MKDirections(request: request)
            directions.calculate { (res, err) in
                if let err = err {print("error is \(err.localizedDescription)")
                    return}
                
                self.route = res?.routes.first
                print(self.route?.steps.forEach({ (step) in
                    print(step.instructions)
                }) ?? 0)
            }
        }
        .store(in: &disposeBag)
    }
}
