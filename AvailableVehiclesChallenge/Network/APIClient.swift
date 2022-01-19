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

struct APIFindParam: Mappable{
    
    var token: String!
    var planets: [PlanetReponse]!
    var vehicles: [VehicleReponse]!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        token  >>> map["token"]
        planets.filter{ $0.name != nil }.map{ $0.name! } >>> map["planet_names"]
        vehicles.filter{ $0.name != nil }.map{ $0.name! } >>> map["vehicle_names"]
    }
}

enum API {
    case token
    case planets
    case vehicles
    case find(param: APIFindParam)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: Endpoints.baseURL)!
    }
    
    var path: String {
        switch self {
        case .token:
            return Endpoints.token
        case .planets:
            return Endpoints.planets
        case .vehicles:
            return Endpoints.vehicles
        case .find:
            return Endpoints.find
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .find, .token:
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


class APIClient{
    
}
