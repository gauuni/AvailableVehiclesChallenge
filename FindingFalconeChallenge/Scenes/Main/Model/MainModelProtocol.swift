//
//  MainModelProtocol.swift
//  FindingFalconeChallenge
//
//  Created by Khoi Nguyen on 1/23/22.
//

import Foundation

protocol MainModelProtocol: BaseModelProtocol{
    var planets: [Planet]! { get }
    func set(planets: [Planet])
    var vehicles: [Vehicle]! { get }
    func set(vehicles: [Vehicle])
    var destinations: [Destination] { get }
    func set(destinations: [Destination])
    var takenTime: Int { get }
    func resetDestinations()
    func initializeDestinations()
    var isValidNumberOfPlanets: Bool{ get }
    var isValidNumberOfVehicles: Bool{ get }
    @discardableResult func update(planet: Planet, at index: Int) -> FFError?
    @discardableResult func update(vehicle: Vehicle, at index: Int) -> FFError?
}
