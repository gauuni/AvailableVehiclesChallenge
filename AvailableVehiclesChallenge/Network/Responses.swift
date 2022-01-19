//
//  BaseResponse.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//


import ObjectMapper

class BaseResponse: Mappable{
    var error: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        error <- map["error"]
    }
    
}

class TokenReponse: BaseResponse{
    var token: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        token <- map["token"]
    }
}

class VehicleReponse: BaseResponse{
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
}

class PlanetReponse: BaseResponse{
    var name: String?
    var distance = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        distance <- map["distance"]
    }
}

