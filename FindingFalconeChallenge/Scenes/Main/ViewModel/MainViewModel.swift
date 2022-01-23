//
//  MainViewModel.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//

import Foundation
import RxSwift

enum ListType{
    case planet
    case vehicle
}

typealias MainDataSourceChangeNotify = (isSuccess: Bool, planet: Planet?, vehicle: Vehicle?)
class MainViewModel: BaseViewModel{
    private let numberOfPlanets = 4
   
    var vehicles: [Vehicle]{
        return model.vehicles
    }
    
    var planets: [Planet]{
        return model.planets
    }
    
    var detinations: [Destination]{
        get{
            return model.destinations
        }
        set{
            model.destinations = newValue
        }
    }
    
    var obsTimeChange = PublishSubject<Int>()
    var obsDataSourceChanged = PublishSubject<MainDataSourceChangeNotify>()
    
    private lazy var model: MainModel = {
       return MainModel()
    }()
    
    override init() {
        super.init()
        
    }

    func initializeData(){
        for idx in 0..<numberOfPlanets{
            let item = Destination()
            item.id = idx+1
            model.destinations.append(item)
        }
        obsDataSourceChanged.onNext((true, nil, nil))
        obsTimeChange.onNext(0)
    }
    
    func loadingResources() -> Observable<Void>{
        let obsPlanets = network.fetchPlanets()
            .do(onNext: { [weak model] items in
                model?.planets = items
            })
            .map{ _ in }
        
        let obsVehicles = network.fetchVehicles()
            .do(onNext: { [weak model] items in
                model?.vehicles = items
            })
            .map{ _ in }
        
        return Observable.zip(obsPlanets, obsVehicles){ _, _ in }

    }
    
    func update(item: Any, at index: Int) {
        
        let destination = model.destinations[index]
        
        let newDestination = Destination()
        newDestination.id = destination.id
        newDestination.planet = destination.planet
        newDestination.vehicle = destination.vehicle
        
        var isSuccess = false
        if let planet = item as? Planet{
            isSuccess = destination.canSelect(planet: planet)
            if isSuccess{
                model.resetIdenticalPlanet(planet)
                newDestination.planet = planet
            } else if let vehicle = destination.vehicle{
                obsDataSourceChanged.onNext((false, planet: planet, vehicle: vehicle))
            }
        }
        
        if let vehicle = item as? Vehicle{
            isSuccess = destination.canSelect(vehicle: vehicle)
            if isSuccess{
                model.updateUnits(vehicle, at: destination)
                newDestination.vehicle = vehicle
            } else if let planet = destination.planet{
                obsDataSourceChanged.onNext((false, planet: planet, vehicle: vehicle))
            }
        }

        if !isSuccess{
            return
        }
      
        model.destinations[index] = newDestination
        obsDataSourceChanged.onNext((true, nil, nil))
        obsTimeChange.onNext(model.takenTime)
        
    }
    
    func update(planet: Planet, at destination: Destination) -> Bool{

        let updatedDestination = Destination()
        updatedDestination.id = destination.id
        updatedDestination.planet = destination.planet
        updatedDestination.vehicle = destination.vehicle
        
        // Reset if same planet has been chosen
        let isSuccess = destination.canSelect(planet: planet)
        if isSuccess{
            model.resetIdenticalPlanet(planet)
            updatedDestination.planet = planet
        } else if let vehicle = destination.vehicle{
            obsDataSourceChanged.onNext((false, planet: planet, vehicle: vehicle))
        }
        
        return isSuccess
    }
    
    func update(vehicle: Vehicle, at destination: Destination) -> Bool{
        let updatedDestination = Destination()
        updatedDestination.id = destination.id
        updatedDestination.planet = destination.planet
        updatedDestination.vehicle = destination.vehicle
        
        let isSuccess = destination.canSelect(vehicle: vehicle)
        if isSuccess{
            model.updateUnits(vehicle, at: destination)
            updatedDestination.vehicle = vehicle
        } else if let planet = destination.planet{
            obsDataSourceChanged.onNext((false, planet: planet, vehicle: vehicle))
        }
        
        return false
    }

    func reset(){
        for destination in detinations{
            if let prevVehicle = destination.vehicle,
               let idx = vehicles.firstIndex(where: { $0 == prevVehicle }){
                let vehicle = vehicles[idx]
                vehicle.units += 1
            }
        }
        model.destinations.removeAll()
        initializeData()
    }
    
    func fetchToken() -> Observable<TokenResponse>{
        return network.fetchToken()
    }

    func findFalcone() -> Observable<FindResult>{
        let obsToken = network.fetchToken()
            .map{ [detinations] res -> APIFindParam in
                var param = APIFindParam()
                param.token = res.token
                param.planets = detinations
                    .filter{ $0.planet != nil }
                .map{ $0.planet! }
                param.vehicles = detinations
                    .filter{ $0.vehicle != nil }
                .map{ $0.vehicle! }
                return param
            }
            .flatMap(network.fetchFind)
            .map{ [model] res -> FindResult in
                res.takenTime = model.takenTime
                return res
            }

        return obsToken
    }
    
}
