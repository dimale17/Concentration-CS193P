//
//  Card.swift
//  Concentration-CS193P
//
//  Created by Dimitris on 11/22/17.
//  Copyright © 2017 CML. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var isEverFlipped = false
    private var identifier : Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}

extension Card : Hashable {
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
