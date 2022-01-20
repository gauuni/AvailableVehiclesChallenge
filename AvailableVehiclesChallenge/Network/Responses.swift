//
//  BaseResponse.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//


import ObjectMapper
import IGListDiffKit

class BaseResponse: Mappable{
    var error: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        error <- map["error"]
    }
    
}

class TokenResponse: BaseResponse{
    var token: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        token <- map["token"]
    }
}

class Vehicle: BaseResponse, Equatable{
    
    var name: String?
    var units: Int = 0
    var maxDistance = 0
    var speed = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        units <- map["total_no"]
        maxDistance <- map["max_distance"]
        speed <- map["speed"]
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.name == rhs.name
    }

}

class Planet: BaseResponse, Equatable{
    var name: String?
    var distance = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        distance <- map["distance"]
    }

    static func == (lhs: Planet, rhs: Planet) -> Bool {
        return lhs.name == rhs.name
    }
    
}

class FindResult: BaseResponse{
    var planetName: String?
    var status: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        planetName <- map["plant_name"]
        status <- map["status"]
    }
}
