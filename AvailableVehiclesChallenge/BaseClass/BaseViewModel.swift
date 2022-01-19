//
//  BaseViewModel.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/19/22.
//

import Foundation

class BaseViewModel{
    let disposeBag = DisposeBag()
    
    public let network = APIClient()
}
