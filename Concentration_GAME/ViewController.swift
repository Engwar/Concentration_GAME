//
//  ViewController.swift
//  Concentration_GAME
//
//  Created by Игорь Шелгинский on 31.03.2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // пишем lazy чтобы инициализация проходила в момент обращения, если убрать lazy то выдаст ошибку с необходимостью инициализации
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    var flipCount = 0 {
        didSet { flipCountLabel.text = "Flips: \(flipCount)"}
    }
    var scoreCount = 0 {
        didSet { scoreGame.text = "Score: \(scoreCount)" }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreGame: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        game.newGame()
        updateViewFromModel()
    }
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    //создаем словарь тем для игры
    var themeGame = [
        "Halloween": ["🦇", "🎃", "👻", "🙀", "🤖", "😱", "😈", "🍭", "🍬", "🍎"],
        "Balls": ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱"],
        "Cars": ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐"],
        "Picture": ["🎑", "🏞", "🌅", "🌄", "🌠", "🎇", "🌇", "🌃", "🌉", "🌁"],
        "Fruit": ["🍌", "🍉", "🍇", "🍓", "🍒", "🍑", "🥭", "🥝", "🍍", "🍋"],
        "Clothes": ["👘", "👙", "👗", "👖", "👔", "🧥", "🥼", "👚", "👕", "🧢"]
    ]
    //создаем случайное число для генерации случайной темы
    //lazy var genTheme = Int(arc4random_uniform(UInt32(themeGame.count)))
    
    var emojiChoices = ["🦇", "🎃", "👻", "🙀", "🤖", "😱", "😈", "🍭", "🍬", "🍎"]
    
    var emoji = [Int: String]()
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

