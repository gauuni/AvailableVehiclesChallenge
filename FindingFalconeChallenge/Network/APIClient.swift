//
//  API.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//

import Moya
import RxSwift
import ObjectMapper

func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? "do null"
    } catch {
        return String(data: data, encoding: .utf8) ?? "catch null"
    }
}

fileprivate struct Endpoints{
    static let baseURL = "https://findfalcone.herokuapp.com/"
    static let token = "token"
    static let planets = "planets"
    static let vehicles = "vehicles"
    static let find = "find"
}

struct APIFindParam: Mappable{
    
    var token: String!
    var planets: [Planet]!
    var vehicles: [Vehicle]!
    
    init(){}
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        token  >>> map["token"]
        planets.filter{ $0.name != nil }.map{ $0.name! } >>> map["planet_names"]
        vehicles.filter{ $0.name != nil }.map{ $0.name! } >>> map["vehicle_names"]
    }
}

enum API {
    case fetchToken
    case fetchPlanets
    case fetchVehicles
    case find(param: APIFindParam)
}

extension API: TargetType {
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


class APIClient{
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background,
                             relativePriority: 1)
        )
    }
    
    private var provider: MoyaProvider<API> = {
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
        let provider = MoyaProvider<API>(plugins: [curlPlugin, bodyPlugin, errorPlugin])
        return provider
    }()
    
    private func request(target: API) -> Observable<Response>{
        return self.provider.rx
            .request(target)
            .retry(1)
            .observe(on: scheduler)
            .asObservable()
    }
}

extension APIClient{
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
    
    func fetchFind(param: APIFindParam) -> Observable<FindResult>{
        request(target: .find(param: param))
            .mapObject(FindResult.self)
    }


}
