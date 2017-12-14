//
//  ViewController.swift
//  Concentration-CS193P
//
//  Created by Dimitris on 11/22/17.
//  Copyright © 2017 CML. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    lazy var game  = Concentration(numberOfPairOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
 
    
    @IBAction func newGame() {
        game  =  Concentration(numberOfPairOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {

        if let cardNumber  = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
           // print("Card Number:\(cardNumber)")
        }
        else {
            //print("Chosen Card was not in cardButtons ")
        }
    }
    
    func updateViewFromModel() {
         flipCountLabel.text = "Flips: \(game.flipCount) - Score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(game.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                button.isUserInteractionEnabled = !card.isMatched
            }
        }
    }
    
}














