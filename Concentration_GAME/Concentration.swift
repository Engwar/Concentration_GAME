//
//  Concentration.swift
//  Concentration_GAME
//
//  Created by Игорь Шелгинский on 16.04.2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private(set) var score = 0
    private(set) var flipcount = 0
    private var seenCards: Set<Int> = []
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched == false {
            flipcount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if card matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if seenCards.contains(index){
                        score -= 1
                    }
                    if seenCards.contains(matchIndex){
                        score -= 1
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are faced up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
    }
    
    func newGame() {
        for flipOver in cards.indices {
            cards[flipOver].isFaceUp = false
            cards[flipOver].isMatched = false
        }
        cards.shuffle()
        score = 0
        flipcount = 0
        seenCards = []
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
        
    }
    
}

