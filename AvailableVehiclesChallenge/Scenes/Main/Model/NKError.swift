//
//  NKError.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/21/22.
//

import Foundation
import UIKit

enum NKError: Error, LocalizedError{
    case cannotReach(planet: Planet, vehicle: Vehicle)

    var localizedDescription: String?{
        switch self{
        case let .cannotReach(planet, vehicle):
            let string = String(format: "%@ cannot reach planet %@", (vehicle.name ?? ""), (planet.name ?? ""))
            return string
        }
    }
}
