//
//  GameModel.swift
//  Memorize
//
//  Created by Hui Hu on 3/4/24.
//

import Foundation

struct GameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> = []
    var score: Int = 0
    var difficulty: Int = 1
    var pairs: Int = 2

    static func getRandomItems(itemList: Array<CardContent>, difficulty: Int = 1) -> Array<CardContent> {
        let num = difficulty * 2
        let randomItems = itemList.shuffled()
        return Array(randomItems[0...(num - 1)])
    }

    init(contentList: Array<CardContent>) {
        score = 0
        cards = []
        let randomList = GameModel<CardContent>.getRandomItems(itemList: contentList, difficulty: 1)
        for pairIndex in 0..<randomList.count {
            let content = randomList[pairIndex]
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
    }

    mutating func updateCards(content: Array<CardContent>) {
        cards = []
        let randomList = GameModel<CardContent>.getRandomItems(itemList: content, difficulty: difficulty)
        for pairIndex in 0..<randomList.count {
            let content = randomList[pairIndex]
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
    }
    
    mutating func reset() {
        difficulty = 1
        pairs = 2
        score = 0
    }


    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }}
    }

    // #TODO: add score system
    mutating func choose(_ card: Card) -> Bool {
        if let choseIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[choseIndex].isFaceUp && !cards[choseIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[choseIndex].content {
                        cards[potentialMatchIndex].isMatched = true
                        cards[choseIndex].isMatched = true
                        score += 2
                        pairs -= 1
                    } else {
                        if cards[choseIndex].hasSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasSeen {
                            score -= 1
                        }
                    }
                    cards[potentialMatchIndex].hasSeen = true
                    cards[choseIndex].hasSeen = true
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = choseIndex
                }
                cards[choseIndex].isFaceUp = true
                
            }
        }
        if pairs == 0 {
            difficulty = min(difficulty + 1, 4)
            pairs = difficulty * 2
            return true
        } else {
            return false
        }
    }

    mutating func shuffle() {
        cards.shuffle()
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var hasSeen = false
        var content: CardContent
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
    
    // score
    func getScore() -> Int {
        return score
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
