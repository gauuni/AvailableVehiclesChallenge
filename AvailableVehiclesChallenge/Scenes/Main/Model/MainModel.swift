//
//  MainModel.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//

import Foundation

class MainModel: BaseModel{
    
    var planets: [Planet]!
    var vehicles: [Vehicle]!
    var destinations = [Destination]()
    
    func resetIdenticalPlanet(_ planet: Planet){
        let idx = destinations.firstIndex{ $0.planet == planet }
        guard let idx = idx
        else{ return }
        
        destinations[idx].planet = nil
    }
    
    func updateUnits(_ selectedVehicle: Vehicle, at index: Int){
        let destination = destinations[index]
    
        // restore units for prev vehicle
        if let prevVehicle = destination.vehicle,
           let idx = vehicles.firstIndex(where: { $0 == prevVehicle }){
            let vehicle = vehicles[idx]
            vehicle.units += 1
        }
        
        // update units selected vehicle
        if let idx = vehicles.firstIndex(where: { $0 == selectedVehicle }){
            let vehicle = vehicles[idx]
            if vehicle.units == 0{ return }
            vehicle.units -= 1
        }
    }
}
