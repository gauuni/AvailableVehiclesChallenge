//
//  FindParam.swift
//  FindingFalconeChallenge
//
//  Created by Khoi Nguyen on 1/23/22.
//

import Foundation
import ObjectMapper

struct FindParam: Mappable{
    
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
