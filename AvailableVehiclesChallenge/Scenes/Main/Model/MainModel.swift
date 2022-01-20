//
//  MainModel.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/19/22.
//

import Foundation
import IGListDiffKit

class Destination: ListDiffable{
    var timestamp = Int(Date().timeIntervalSince1970)
    var id: Int = -1
    var planet: Planet?
    var vehicle: Vehicle?
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSNumber
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Destination else { return false }
        return self.timestamp == object.timestamp &&
        self.id == object.id
        
    }
    
}

class MainModel: BaseModel{
    
    var planets: [Planet]!
    var vehicles: [Vehicle]!
    var destinations = [Destination]()
}
