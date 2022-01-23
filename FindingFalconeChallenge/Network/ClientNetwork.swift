//
//  API.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//

import Moya
import RxSwift
import ObjectMapper

fileprivate struct Endpoints{
    static let baseURL = "https://findfalcone.herokuapp.com/"
    static let token = "token"
    static let planets = "planets"
    static let vehicles = "vehicles"
    static let find = "find"
}

enum ClientAPI {
    case fetchToken
    case fetchPlanets
    case fetchVehicles
    case find(param: FindParam)
}

extension ClientAPI: TargetType {
    var baseURL: URL {
        return URL(string: Endpoints.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchToken:
            return Endpoints.token
        case .fetchPlanets:
            return Endpoints.planets
        case .fetchVehicles:
            return Endpoints.vehicles
        case .find:
            return Endpoints.find
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .find, .fetchToken:
            return .post
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .find(let param):
            return .requestParameters(parameters: param.toJSON(), encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers = ["Accept": "application/json"]
        switch self {
        case .find:
            headers["Content-Type"] = "application/json"
        default:
            break
        }
        return headers
    }
}


class ClientNetwork: BaseNetwork<ClientAPI>{
    
}

extension ClientNetwork{
    func fetchToken() -> Observable<TokenResponse>{
        return request(target: .fetchToken)
            .mapObject(TokenResponse.self)
    }
    
    func fetchPlanets() -> Observable<[Planet]>{
        return request(target: .fetchPlanets)
            .mapArray(Planet.self)
    }
    
    func fetchVehicles() -> Observable<[Vehicle]>{
        return request(target: .fetchVehicles)
            .mapArray(Vehicle.self)
    }
    
    func fetchFind(param: FindParam) -> Observable<FindResult>{
        request(target: .find(param: param))
            .mapObject(FindResult.self)
    }


}
