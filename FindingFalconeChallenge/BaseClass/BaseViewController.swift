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
    
    var viewModel: BaseViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setup(viewModel: BaseViewModelProtocol?){
        self.viewModel = viewModel
    }

}
