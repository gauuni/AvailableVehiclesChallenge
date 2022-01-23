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

class FindResult: BaseResponse{
    var planetName: String?
    var status: String?
    var takenTime: Int = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        planetName <- map["planet_name"]
        status <- map["status"]
    }
}
