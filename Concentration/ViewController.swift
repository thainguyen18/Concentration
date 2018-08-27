//
//  ViewController.swift
//  Concentration
//
//  Created by Thai Nguyen on 8/20/18.
//  Copyright © 2018 Thai Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            
        }
    }
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : chosenCardColor
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
        
        flipCountLabel.text = "Flips: \(game.flipsCount)"
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var themes = ["animals":["🐶","🐱","🐰","🦊","🦁","🐵","🦆","🕷","🦂","🐟","🐍","🐿"],
                  "sports":["⚽️","🏀","🏈","🎱","🏓","🏹","⛸","⛷","🎣","🥊","🎾","🏐"],
                  "faces":["😄","☺️","😍","😂","😡","😈","😱","😤","😐","😵","😇","😎"],
                    "fruits":["🍎","🍊","🍋","🍌","🍉","🍓","🥑","🌽","🍅","🍍","🥦","🥒"],
                    "objects":["⌚️","📱","💻","🖨","🖱","📷","📺","🎥","🔦","⏰","💎","💰"],
                    "flags":["🇻🇳","🇺🇸","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🇧🇷","🇫🇷","🇩🇪","🇮🇹","🇨🇳","🇯🇵","🇪🇸","🇰🇷","🇨🇭"]
                  ]
    
    private var backgroundColors = ["animals":#colorLiteral(red: 0.13333, green: 0.13333, blue: 0.13333, alpha: 1), "sports":#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), "faces":#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), "fruits":#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), "objects":#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), "flags":#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)]
    
    private var cardBackColors = ["animals":#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), "sports":#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), "faces":#colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), "fruits":#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), "objects":#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), "flags":#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)]
    
    private var chosenCardColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    
    private var emojiChoices = [String]()
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomThemeForgame()
        
        updateViewFromModel()
    }
    
    
    private func randomThemeForgame() {
        let themeKeys = Array(themes.keys)
        let randomThemeKey = Int(arc4random_uniform(UInt32(themeKeys.count)))
        emojiChoices = themes[themeKeys[randomThemeKey]] ?? []
        self.view.backgroundColor = backgroundColors[themeKeys[randomThemeKey]] ?? #colorLiteral(red: 0.13333, green: 0.13333, blue: 0.13333, alpha: 1)
        chosenCardColor = cardBackColors[themeKeys[randomThemeKey]] ?? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    }
   
    
    @IBAction private func touchNewGame(_ sender: Any) {
        game.resetGame()
        emoji.removeAll()
        randomThemeForgame()
        updateViewFromModel()
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

