//
//  MainViewModelProtocol.swift
//  FindingFalconeChallenge
//
//  Created by Khoi Nguyen on 1/23/22.
//

import Foundation
import RxSwift

protocol MainViewModelProtocol: BaseViewModelProtocol{
    
    var vehicles: [Vehicle]{ get }
    var planets: [Planet]{ get }
    var destinations: [Destination]{ get }
    
    
        
    var obsTimeChange: PublishSubject<Int> { get }
    var obsDataSourceChanged: PublishSubject<Result<Bool, FFError>> { get }
    
    func initializeData()
    func loadingResources() -> Observable<Void>
    func update(item: Any, at index: Int)
    func reset()
    func findFalcone() -> Observable<FindResult>
    
}
