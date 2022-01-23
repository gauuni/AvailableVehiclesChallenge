//
//  BaseViewModel.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/19/22.
//

import Foundation
import RxSwift

class BaseViewModel{
    let disposeBag = DisposeBag()
    
    var model: BaseModelProtocol?
    var network = NetworkManager()
    
    init(model: BaseModelProtocol){
        self.model = model
    }
    
}
