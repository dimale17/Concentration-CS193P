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
    private(set) var cards = [Card]()
    
    var score = 0
    var flipCount = 0
    
    var emojiChoices = [ "🐧" , "👻", "✏️" ,"🏀", "🐼", "🎃",  "😈", "🤖","👨🏻‍🎓","🦋","🦆","☘️", "☃️"]
    
    
    
    var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            var foundIndex  : Int?
            for index in cards.indices {
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
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
    
    
    
    
    
    func chooseCard(at index : Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index] {
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
                
            }
            else {
                // either no cards or 2 cards are face up
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
         cards.shuffle()
        //cards.shuffled()

    }

    var emoji = [ Card : String] ()
    
    func emoji(for card : Card) -> String {
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            let randomIndex = randomStringIndex
            emoji[card] = emojiChoices.remove(at: randomIndex)

        }
        return  emoji[card] ?? "?"
    }
}


extension Int {
    var arc4random : Int {
        switch self {
        case 1...:   // Greater than zero
            return Int(arc4random_uniform(UInt32(self)))
        case  ..<0 :  // Less than Zero
            return  -Int(arc4random_uniform(UInt32(abs(self))))
        case 0 :
            return self
        default:
            fatalError("Unreachable Integer!")
        }
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

//MARK: - Functional Approach

extension MutableCollection  {
    
    // Fisher-Yates (fast an uniform) shuffle
    // Shuffles the contents of this collection.
    
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
    }
}



extension Sequence {
    
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
