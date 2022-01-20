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
    private let numberOfPlanets = 4
   
    var vehicles: [Vehicle]{
        return model.vehicles
    }
    
    var planets: [Planet]{
        return model.planets
    }
    
    var detinations: [Destination]{
        return model.destinations
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
        obsDataSourceChanged.onNext(model.destinations)
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
        
        return Observable.merge(obsPlanets, obsVehicles)
    }
    
    func update(item: Any, at index: Int){

        let destination = model.destinations[index]

        if let item = item as? Planet{
            // Check if any planet has been chosen
            if let idx = model.destinations
                .firstIndex(where: { $0.planet?.name == item.name }){
                model.destinations[idx].planet = nil
            }
                
            destination.planet = item
        }
        
        if let item = item as? Vehicle{
            // restore units for prev vehicle
            if let prevVehicle = destination.vehicle,
               let idx = model.vehicles.firstIndex(where: { $0.name == prevVehicle.name }){
                model.vehicles[idx].units += 1
            }
            
            // update units selected vehicle
            if let idx = model.vehicles.firstIndex(where: { $0.name == item.name }){
                model.vehicles[idx].units -= 1
            }
        
            destination.vehicle = item

        }
        
     
        let newDestination = Destination()
        newDestination.id = destination.id
        newDestination.planet = destination.planet
        newDestination.vehicle = destination.vehicle
        
        model.destinations[index] = newDestination
        obsDataSourceChanged.onNext(model.destinations)
        
        let totalTime = model.destinations
            .filter{ $0.vehicle != nil && $0.planet != nil }
            .map{ $0.planet!.distance / $0.vehicle!.speed }
            .reduce(0, +)
        obsTimeChange.onNext(totalTime)
    }
    
    func reset(){
        model.destinations.removeAll()
        initializeData()
    }
//    network.fetchToken()
//        .subscribe()
//        .disposed(by: disposeBag)
   
    
}
