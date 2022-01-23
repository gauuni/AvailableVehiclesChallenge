//
//  BaseNetwork.swift
//  FindingFalconeChallenge
//
//  Created by Khoi Nguyen on 1/23/22.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? "do null"
    } catch {
        return String(data: data, encoding: .utf8) ?? "catch null"
    }
}

class BaseNetwork<T: TargetType>{
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background,
                             relativePriority: 1)
        )
    }
    
    private var provider: MoyaProvider<T> = {
        let curlPlugin = NetworkLoggerPlugin(
            configuration: .init(
                                 logOptions: .formatRequestAscURL
            )
        )
        
        let bodyPlugin = NetworkLoggerPlugin(
            configuration: .init(
                                 logOptions: .successResponseBody
            )
        )
        
        let errorPlugin = NetworkLoggerPlugin(
            configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                 logOptions: .errorResponseBody
            )
        )
        let provider = MoyaProvider<T>(plugins: [curlPlugin, bodyPlugin, errorPlugin])
        return provider
    }()
    
    func request(target: T) -> Observable<Response>{
        return self.provider.rx
            .request(target)
            .retry(1)
            .observe(on: scheduler)
            .asObservable()
    }
}
