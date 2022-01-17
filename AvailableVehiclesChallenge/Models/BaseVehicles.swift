//
//  BaseVehicles.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/17/22.
//

import Foundation

enum VehicleType{
    case pod
    case rocket
    case shuttle
    case ship
    
    func getProperties() -> (name: String,
                             units: Int,
                             maxDistance: Int,
                             speed: Int){
        switch self {
        case .pod:
            return ("Space Pod", 2, 200, 2)
        case .rocket:
            return ("Space Rocket", 1, 300, 4)
        case .shuttle:
            return ("Space Shuttle", 1, 400, 5)
        case .ship:
            return ("Space Ship", 2, 600, 10)
        }
    }
}

class Vehicles{
    let name: String
    var units: Int
    let maxDistance: Int //in megamiles
    let speed: Int //in megamiles/hour
    
    init(type: VehicleType) {
        let properties = type.getProperties()
        self.name = properties.name
        self.units = properties.units
        self.maxDistance = properties.maxDistance
        self.speed = properties.speed
    }
    
}

enum PlannetType{
    case donlon
    case enchai
    case jebing
    case sapir
    case lerbin
    case pingasor

    func getProperties() -> (name: String,
                             distance: Int){
        switch self {
        case .donlon:
            return ("Donlon", 100)
        case .enchai:
            return ("Enchai", 200)
        case .jebing:
            return ("Jebing", 300)
        case .sapir:
            return ("Sapir", 400)
        case .lerbin:
            return ("Lerbin", 500)
        case .pingasor:
            return ("Pingasor", 600)
        }
    }
}

class Planet{
    let name: String
    let distance: Int
    
    init(type: PlannetType) {
        let properties = type.getProperties()
        self.name = properties.name
        self.distance = properties.distance
    }
}
