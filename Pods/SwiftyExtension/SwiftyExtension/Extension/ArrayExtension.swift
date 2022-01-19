//
//  ArrayExtension.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/31/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation

public extension Array {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }

    func printJson() {
        print(json)
    }
}

public extension Array where Element: AnyObject {
    mutating func remove(object: Element) {
        if let index = firstIndex(where: { $0 === object }) {
            remove(at: index)
        }
    }
}


public extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

public extension Array where Element: AnyObject {
    
    func get(offset: Int, limit: Int ) -> Array<Element> {
        //create variables
        var lim = 0 // how much to take
        var off = 0 // start from
        var l: Array<Element> = Array<Element>() // results list
        
        //check indexes
        if off<=offset && offset<self.count - 1 {
            off = offset
        }
        if limit > self.count {
            lim = self.count
        }else{
            lim = limit
        }
        
        //do slicing
        for i in off..<lim{
            let dog = self[i]
            l.append(dog)
        }
        
        //results
        return l
    }
}
