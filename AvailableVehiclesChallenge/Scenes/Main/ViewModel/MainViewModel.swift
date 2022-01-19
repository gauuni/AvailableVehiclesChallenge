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

    var obsPlanets: Observable<[Planet]>{
        return Observable.create { [weak model] observer in
            guard let planets = model?.planets
            else {
                let result = network.fetchPlanets()
                return result.

            }
            return
        }
    }
    
    var vehicles: [Vehicle]!{
        return model.vehicles
    }
    
    private lazy var model: MainModel = {
       return MainModel()
    }()
    
    func presentList(viewController: PanViewController, type: ListType){
        switch type {
        case .planet:
            <#code#>
        case .vehicle:
            <#code#>
        }
    }
    
    private func presentPlanet(viewController: PanViewController){
        guard let planets = model.planets
        else {
            network.fetchPlanets()
                .subscribe(onNext: { [weak model] planets in
                    model?.planets = planets
                    viewController.items = model?.planets
                    self.
                }, onError: { error in
                    
                })
                .disposed(by: disposeBag)
            return
        }
        
        
    }
    
    private func presentVehicle(viewController: PanViewController){
        network.fetchVehicles()
            .subscribe()
            .disposed(by: disposeBag)
    }
    
//    network.fetchToken()
//        .subscribe()
//        .disposed(by: disposeBag)
   
    
}
