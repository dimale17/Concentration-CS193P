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
    var indexOfOneAndOnlyFaceUpCard : Int?
    
    
    func chooseCard(at index : Int) {
//cards[index].isFaceUp = !cards[index].isFaceUp
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match

                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
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
        
    }
    
}
