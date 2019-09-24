//
//  Card.swift
//  Concentration_GAME
//
//  Created by Игорь Шелгинский on 16.04.2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
         self.identifier = Card.getUniqueIdentifier()
    }
}
