//
//  ViewController.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/17/22.
//

import UIKit
import RxSwift

class MainViewController: BaseViewController {

    let network = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.fetchToken()
            .subscribe()
            .disposed(by: disposeBag)
        network.fetchVehicles()
            .subscribe()
            .disposed(by: disposeBag)
        network.fetchPlanets()
            .subscribe()
            .disposed(by: disposeBag)
    }


}

