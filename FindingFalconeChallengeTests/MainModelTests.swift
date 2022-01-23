//
//  MainModelTests.swift
//  FindingFalconeChallengeTests
//
//  Created by Khoi Nguyen on 1/23/22.
//

import XCTest

@testable import FindingFalconeChallenge

class MainModelTests: XCTestCase {

    var model: MainModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = MainModel()
        model.initializeDestinations()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model = nil
    }
    
    func testInitializeData() throws{
        XCTAssertEqual(model.destinations.count, 4)
    }

    func testTakenTime() throws {
        let vehicle = Vehicle()
        vehicle.speed = 4

        let planet = Planet()
        planet.distance = 600
        
        let destination = model.destinations.first
        destination?.planet = planet
        destination?.vehicle = vehicle
        
        XCTAssertEqual(model.takenTime, 150)
    }
    
    func testUpdateUnitVehicle() throws {
        let vehicle1 = Vehicle()
        vehicle1.name = "test1"
        vehicle1.units = 1

        let vehicle2 = Vehicle()
        vehicle2.name = "test2"
        vehicle2.units = 2
        model.set(vehicles: [vehicle1, vehicle2])
        
        model.update(vehicle: vehicle1, at: 0)
        model.update(vehicle: vehicle2, at: 1)

        XCTAssertEqual(vehicle1.units, 0)
        XCTAssertEqual(vehicle2.units, 1)
    }
    
    func testUpdateUnitExistedVehicleInDestination() throws {
        let vehicle1 = Vehicle()
        vehicle1.name = "test1"
        vehicle1.units = 1
        
        let vehicle2 = Vehicle()
        vehicle2.name = "test2"
        vehicle2.units = 2
        model.set(vehicles: [vehicle1, vehicle2])
        
        model.update(vehicle: vehicle1, at: 0)
        model.update(vehicle: vehicle2, at: 1)

        XCTAssertEqual(vehicle1.units, 0)
        XCTAssertEqual(vehicle2.units, 1)
        
        model.update(vehicle: vehicle2, at: 0)

        XCTAssertEqual(vehicle1.units, 1)
    }
    
    func testUpdatePlanet() throws {
        let planet = Planet()
        planet.name = "Test planet"
        planet.distance = 600
        
        let destination = model.destinations.first
        destination?.planet = planet
        XCTAssertNotNil(destination)
        XCTAssertNotNil(destination?.planet)
        XCTAssertEqual(destination!.planet?.name, "Test planet")
        XCTAssertEqual(destination!.planet?.distance, 600)
    }

    func testUpdateIdenticalPlanet() throws {
        let planet = Planet()
        planet.name = "Test planet"
        planet.distance = 600
        
        model.update(planet: planet, at: 0)
        let destination = model.destinations.first
        XCTAssertNotNil(destination)
        XCTAssertNotNil(destination?.planet)
        XCTAssertEqual(destination!.planet?.name, "Test planet")
        XCTAssertEqual(destination!.planet?.distance, 600)
        
        model.update(planet: planet, at: 3)
        let lastDestination = model.destinations.last
        XCTAssertNotNil(lastDestination)
        XCTAssertNotNil(lastDestination?.planet)
        XCTAssertEqual(lastDestination!.planet?.name, "Test planet")
        XCTAssertEqual(lastDestination!.planet?.distance, 600)
        
        XCTAssertNil(model.destinations.first?.planet)
    }
    
    func testErrorUnreachablePlanet () throws {
        let planet = Planet()
        planet.distance = 600
        model.set(planets: [planet])
        let vehicle1 = Vehicle()
        vehicle1.name = "test1"
        vehicle1.maxDistance = 200
        model.set(vehicles: [vehicle1])
        
        let updatePlanetError = model.update(planet: planet, at: 0)
        XCTAssertNil(updatePlanetError)
        
        let updateVehicleError = model.update(vehicle: vehicle1, at: 0)
        XCTAssertEqual(updateVehicleError, FFError.unreachable(planet: planet, vehicle: vehicle1))
    }
    
    func testErrorIdenticalVehicle() throws {
        let vehicle1 = Vehicle()
        vehicle1.name = "test1"
        vehicle1.maxDistance = 200
        model.set(vehicles: [vehicle1])

        let updateVehicleError = model.update(vehicle: vehicle1, at: 0)
        XCTAssertNil(updateVehicleError)
        let updateVehicleError1 = model.update(vehicle: vehicle1, at: 0)
        XCTAssertEqual(updateVehicleError1, FFError.identical(vehicle: vehicle1))
        
    }

}
