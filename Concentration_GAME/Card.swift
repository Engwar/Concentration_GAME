//
//  Card.swift
//  Concentration_GAME
//
//  Created by Игорь Шелгинский on 16.04.2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFuctory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFuctory += 1
        return identifierFuctory
    }
    
    init() {
         self.identifier = Card.getUniqueIdentifier()
    }
}
