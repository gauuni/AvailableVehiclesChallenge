//
//  Vehicle.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/21/22.
//

import ObjectMapper
import IGListDiffKit

class Vehicle: BaseResponse{
    
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
    
    func diffIdentifier() -> NSObjectProtocol {
        return (name ?? "") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.name == rhs.name &&
        lhs.units == rhs.units &&
        lhs.maxDistance == rhs.maxDistance &&
        lhs.speed == rhs.speed
    }

}
