//
//  BaseViewController.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/17/22.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var model: BaseModel!
    var viewModel: BaseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setup(model: BaseModel, viewModel: BaseViewModel){
        self.model = model
        self.viewModel = viewModel
    }
}
