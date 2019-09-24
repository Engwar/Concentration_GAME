//
//  Concentration.swift
//  Concentration_GAME
//
//  Created by Игорь Шелгинский on 16.04.2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private(set) var score = 0
    private(set) var flipcount = 0
    private var seenCards: Set<Int> = []
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
//            let faceUpCardIndices = cards.indices.filter {cards[$0].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        //здесть assert это утверждение что  выбранная карта содержится в массиве карт, в противном случае  - ошибка
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
        if cards[index].isMatched == false {
            flipcount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if card matched
                if cards[matchIndex] == cards[index] {
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
            } else {
                //either no cards or 2 cards are faced up
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
    }
    
    mutating func newGame() {
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
        // здесь assert - утверждение, что число пар карт должно быть больше нуля, в противном случае - выдаст ошибку
        assert(numberOfPairsOfCards > 0, "Concentration init: (\(numberOfPairsOfCards)): you must have at least one of pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
        
    }
    
}

