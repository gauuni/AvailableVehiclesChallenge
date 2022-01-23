//
//  Planet.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/21/22.
//

import ObjectMapper
import IGListDiffKit

class Planet: BaseResponse, ListDiffable{
    var name: String?
    var distance = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        distance <- map["distance"]
    }

    func diffIdentifier() -> NSObjectProtocol {
        return (name ?? "") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
    
    static func == (lhs: Planet, rhs: Planet) -> Bool {
        return lhs.name == rhs.name &&
        lhs.distance == rhs.distance
    }
    
}
