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

class MainViewModel: BaseViewModel{
    private let numberOfPlanets = 100
   
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
    var obsDataSourceChanged = PublishSubject<[Destination]>()
    
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
        obsDataSourceChanged.onNext([])
        obsTimeChange.onNext(0)
    }
    
    func loadingResources() -> Observable<Void>{
        let obsPlanets = network.fetchPlanets()
            .do(onNext: { [weak model] planets in
                model?.planets = planets
            })
            .map{ _ in }
        
        let obsVehicles = network.fetchVehicles()
            .do(onNext: { [weak model] vehicles in
                model?.vehicles = vehicles
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
        if let item = item as? Planet{
            // Reset if same planet has been chosen
            isSuccess = destination.canSelect(planet: item)
            if isSuccess{
                model.resetIdenticalPlanet(item)
                newDestination.planet = item
            }else{
                if let vehicle = destination.vehicle{
                    obsDataSourceChanged.onError(NKError.cannotReach(planet: item, vehicle: vehicle))
                    return
                }
            }
        }
        
        if let item = item as? Vehicle{
            isSuccess = destination.canSelect(vehicle: item)
            if isSuccess{
                model.updateUnits(item, at: index)
                newDestination.vehicle = item
            }else{
                if let planet = destination.planet{
                    obsDataSourceChanged.onError(NKError.cannotReach(planet: planet, vehicle: item))
                    return
                }
                
            }
        }

      
            model.destinations[index] = newDestination
            obsDataSourceChanged.onNext([])
            
            let totalTime = model.destinations
                .map{ $0.takenTime }
                .reduce(0, +)
            obsTimeChange.onNext(totalTime)
        
    }
    
    func update(vehicle: Vehicle){
        
    }
    
    func update(planet: Planet){
        
    }
    
    func reset(){
        model.destinations.removeAll()
        initializeData()
    }
//    network.fetchToken()
//        .subscribe()
//        .disposed(by: disposeBag)
   
    
}
