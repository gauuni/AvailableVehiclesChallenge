//
//  NetworkManager.swift
//  FindingFalconeChallenge
//
//  Created by Khoi Nguyen on 1/23/22.
//

import Foundation

class NetworkManager{
    var client: ClientNetwork = {
        return ClientNetwork()
    }()
}
