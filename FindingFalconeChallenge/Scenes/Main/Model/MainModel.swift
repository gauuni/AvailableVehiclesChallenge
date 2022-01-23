//
//  MainModel.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//

import Foundation

fileprivate let NUMBER_OF_PLANETS = 4

class MainModel: BaseModel, MainModelProtocol{
    
    var planets: [Planet]!
    var vehicles: [Vehicle]!
    var destinations = [Destination]()
    
    func set(planets: [Planet]){
        self.planets = planets
    }
    
    func set(vehicles: [Vehicle]){
        self.vehicles = vehicles
    }
    
    func set(destinations: [Destination]){
        self.destinations = destinations
    }
    
    var takenTime: Int{
        return destinations
            .map{ $0.takenTime }
            .reduce(0, +)
    }
    
    func resetIdenticalPlanet(_ planet: Planet){
        if let idx = destinations.firstIndex(where: { $0.planet == planet }){
            let foundDestination = destinations[idx]
            let updatedDestination = Destination()
            updatedDestination.id = foundDestination.id
            updatedDestination.vehicle = foundDestination.vehicle
            updatedDestination.planet = nil
            destinations[idx] = updatedDestination
        }
    }
    
    func updateUnits(_ vehicle: Vehicle, at destination: Destination){
    
        // restore units for prev vehicle
        if let prevVehicle = destination.vehicle,
           let vehicle = vehicles.first(where: { $0 == prevVehicle }){
            vehicle.units += 1
        }
        
        // update units selected vehicle
        if let foundVehicle = vehicles.first(where: { $0 == vehicle }),
           foundVehicle.units > 0{
            foundVehicle.units -= 1
        }
    }
    
    @discardableResult func update(planet: Planet, at index: Int) -> FFError?{
        let destination = destinations[index]
        
        // Planet's distance is out of reach of vehicle
        if let vehicle = destination.vehicle,
        planet.distance > vehicle.maxDistance{
            return .unreachable(planet: planet,
                                vehicle: vehicle)
        }
        
        // Everything is fine
        resetIdenticalPlanet(planet)

        let updatedDestination = Destination()
        updatedDestination.id = destination.id
        updatedDestination.vehicle = destination.vehicle
        updatedDestination.planet = planet
        destinations[index] = updatedDestination
        
        return nil
    }
    
    @discardableResult func update(vehicle: Vehicle, at index: Int) -> FFError?{
        let destination = destinations[index]
        
        if vehicle == destination.vehicle{
            return .identical(vehicle: vehicle)
        }
        
        if let planet = destination.planet,
        planet.distance > vehicle.maxDistance{
            return .unreachable(planet: planet,
                                vehicle: vehicle)
        }
        
        updateUnits(vehicle, at: destination)

        let updatedDestination = Destination()
        updatedDestination.id = destination.id
        updatedDestination.vehicle = vehicle
        updatedDestination.planet = destination.planet
        destinations[index] = updatedDestination
        
        return nil
    }
    
    func resetDestinations(){
        for destination in destinations{
            if let prevVehicle = destination.vehicle,
               let idx = vehicles.firstIndex(where: { $0 == prevVehicle }){
                let vehicle = vehicles[idx]
                vehicle.units += 1
            }
        }
        
        destinations.removeAll()
    }
    
    func initializeDestinations(){
        for idx in 0..<NUMBER_OF_PLANETS{
            let item = Destination()
            item.id = idx+1
            destinations.append(item)
        }
    }
}
