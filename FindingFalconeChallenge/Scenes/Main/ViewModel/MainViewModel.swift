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
class MainViewModel: BaseViewModel, MainViewModelProtocol{
    
   
    var vehicles: [Vehicle]{
        return mainModel.vehicles
    }
    
    var planets: [Planet]{
        return mainModel.planets
    }
    
    var destinations: [Destination]{
        return mainModel.destinations
    }
    
    
    var obsTimeChange = PublishSubject<Int>()
    var obsDataSourceChanged = PublishSubject<Result<Bool, FFError>>()
    
    private var mainModel: MainModelProtocol {
        return self.model as! MainModelProtocol
    }


    func initializeData(){
        mainModel.initializeDestinations()
        obsDataSourceChanged.onNext(.success(true))
        obsTimeChange.onNext(0)
    }
    
    func loadingResources() -> Observable<Void>{
        let obsPlanets = network.client.fetchPlanets()
            .do(onNext: { [mainModel] items in
                mainModel.set(planets: items)
            })
            .map{ _ in }
        
        let obsVehicles = network.client.fetchVehicles()
            .do(onNext: { [mainModel] items in
                mainModel.set(vehicles: items)
            })
            .map{ _ in }
        
        return Observable.zip(obsPlanets, obsVehicles){ _, _ in }

    }
    
    func update(item: Any, at index: Int) {
        if let planet = item as? Planet{
            let error = mainModel.update(planet: planet, at: index)
            if let error = error {
                obsDataSourceChanged.onNext(.failure(error))
                return
            }
        }
        
        if let vehicle = item as? Vehicle{
            let error = mainModel.update(vehicle: vehicle, at: index)

            if let error = error {
                obsDataSourceChanged.onNext(.failure(error))
                return
            }
        }

        obsDataSourceChanged.onNext(Result.success(true))
        obsTimeChange.onNext(mainModel.takenTime)
    }

    func reset(){
        mainModel.resetDestinations()
        initializeData()
    }

    func findFalcone() -> Observable<FindResult>{
        if !mainModel.isValidNumberOfPlanets{
            return Observable.error(FFError.noOfPlanets)
        }
        
        if !mainModel.isValidNumberOfVehicles{
            return Observable.error(FFError.noOfVehicle)
        }
        
        let obsToken = network.client.fetchToken()
            .map{ [destinations] res -> FindParam in
                var param = FindParam()
                param.token = res.token
                param.planets = destinations
                    .filter{ $0.planet != nil }
                .map{ $0.planet! }
                param.vehicles = destinations
                    .filter{ $0.vehicle != nil }
                .map{ $0.vehicle! }
                return param
            }
            .flatMap(network.client.fetchFind)
            .map{ [mainModel] res -> FindResult in
                res.takenTime = mainModel.takenTime
                return res
            }

        return obsToken
    }
    
}
