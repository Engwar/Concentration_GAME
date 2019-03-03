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
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var themeName: UILabel!
    @IBOutlet weak var scoreGame: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGame: UIButton!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        updateViewFromModel()
        indexTheme = Int.random(in: 0..<themeGame.count) //генератор случайного числа
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme = Int.random(in: 0..<themeGame.count)
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
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
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeGame[indexTheme].cardColor
            }
        }
        scoreGame.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipcount)"
        view.backgroundColor = themeGame[indexTheme].viewColor
        flipCountLabel.textColor = themeGame[indexTheme].cardColor
        scoreGame.textColor = themeGame[indexTheme].cardColor
        themeName.textColor = themeGame[indexTheme].cardColor
        newGame.setTitleColor(themeGame[indexTheme].viewColor, for: .normal)
        newGame.backgroundColor = themeGame[indexTheme].cardColor
    }
    
    private struct Theme {
        var name:String
        var pics:[String]
        var viewColor: UIColor
        var cardColor: UIColor
    }
    //создаем словарь тем для игры
    private var themeGame: [Theme] = [
        Theme(name: "Halloween",
          pics: ["🦇", "🎃", "👻", "🙀", "☠️", "😱", "😈", "🍭", "🍬", "🍎", "🤖", "🕸"],
          viewColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
          cardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
        Theme(name: "Balls",
              pics: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏸", "🏓"],
              viewColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),
              cardColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Theme(name: "Cars",
              pics: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚜", "🏍"],
              viewColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),
              cardColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
        Theme(name: "Picture",
              pics: ["🎑", "🏞", "🌅", "🌄", "🌠", "🎇", "🌇", "🌃", "🌉", "🌁", "🏙", "🗾"],
              viewColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
              cardColor: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)),
        Theme(name: "Fruit",
              pics: ["🍌", "🍉", "🍇", "🍓", "🍒", "🍑", "🥭", "🥝", "🍍", "🍋", "🍈", "🥥"],
              viewColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
              cardColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)),
        Theme(name: "Clothes",
              pics: ["👘", "👙", "👗", "👖", "👔", "🧥", "🥼", "👚", "👕", "🧢","🥋", "🧦"],
              viewColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
              cardColor: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    ]
    
    
    var emojiChoices = [String]()
    
    private var indexTheme = 0 {
        didSet {
            emojiChoices = themeGame[indexTheme].pics
            emoji = [Int: String]()
            themeName.text = themeGame[indexTheme].name
            updateViewFromModel()
            print(indexTheme, emojiChoices)
        }
    }
    var emoji = [Int: String]()
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: Int.random(in: 0..<emojiChoices.count))
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

