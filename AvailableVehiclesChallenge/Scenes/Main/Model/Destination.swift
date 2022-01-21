//
//  Destination.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/21/22.
//

import ObjectMapper
import IGListDiffKit

class Destination: ListDiffable, Equatable{
    var timestamp = Int(Date().timeIntervalSince1970)
    var id: Int = -1
    var planet: Planet?
    var vehicle: Vehicle?
    var planetName: String?
    var vehicleName: String?
    
    var takenTime: Int{
        guard let planet = planet,
              let vehicle = vehicle
        else{
            return 0
        }
        
        return planet.distance / vehicle.speed
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Destination else { return false }
        return self.id == object.id &&
        self.planet == object.planet &&
        self.vehicle == object.vehicle
    }
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        return lhs.id == rhs.id &&
        lhs.planet == rhs.planet &&
        lhs.vehicle == rhs.vehicle
    }
    
    func canSelect(planet: Planet) -> Bool{
        guard let vehicle = vehicle
        else{ return true }
        
        if planet.distance > vehicle.maxDistance{
            return false
        }
        
        return true
    }
 
    func canSelect(vehicle: Vehicle) -> Bool{
        if vehicle == self.vehicle{
            return false
        }
        
        guard let planet = planet
        else{ return true }
        
        if planet.distance > vehicle.maxDistance{
            return false
        }
        
        return true
    }
}
