//
//  Concentration.swift
//  Concentration-CS193P
//
//  Created by Dimitris on 11/22/17.
//  Copyright © 2017 CML. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var score = 0
    var flipCount = 0
    
    var emojiChoices = [ "🐧" , "👻", "✏️" ,"🏀", "🐼", "🎃",  "😈", "🤖","👨🏻‍🎓","🦋","🦆","☘️", "☃️"]
    
    var indexOfOneAndOnlyFaceUpCard : Int?
    
    
    func chooseCard(at index : Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score +=  2
                }
                else
                {
                    score -= cards[index].isEverFlipped  ? 1 : 0
                    score -= cards[matchIndex].isEverFlipped ? 1 : 0
                    cards[index].isEverFlipped = true
                    cards[matchIndex].isEverFlipped = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard  = index
            }
        }
    }
    
    
    init (numberOfPairOfCards : Int)  {
        
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        
         //TODO: Shuffle the Cards
         cards.shuffled()

    }

    var emoji = [ Int: String] ()
    
    func emoji(for card : Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return  emoji[card.identifier] ?? "?"
        
    }
}

extension Array {
    mutating func shuffled() {
        var unshuffled = self
        self.removeAll()
        for _ in unshuffled.indices
        {
            let rand = Int(arc4random_uniform(UInt32(unshuffled.count)))
            self.append(unshuffled[rand])
            unshuffled.remove(at: rand)
        }
    }
}
