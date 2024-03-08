//
//  GameViewModel.swift
//  Memorize
//
//  Created by Hui Hu on 3/4/24.
//

import SwiftUI


class GameViewModel: ObservableObject {
    private var themes: ThemeModel
    @Published private var game: GameModel<String>

    init() {
        let initialThemes = ThemeModel([])
        self.themes = initialThemes
        self.game = GameModel<String>(contentList: initialThemes.currentTheme.emojis)
    }

    var cards: Array<GameModel<String>.Card> {
        return game.cards;
    }

    // MARK: - Intents
    func newGame(archive: Bool = true) {
        themes.updateTheme()
        game.updateCards(content: themes.currentTheme.emojis)
        if !archive {
            game.reset()
        }
    }

    // MARK: - Intents
    func shuffle() {
        game.shuffle()
    }

    func choose(_ card: GameModel<String>.Card) -> Bool {
        let res = game.choose(card)
        objectWillChange.send()
        if res {
            return true
        } else {
            return false
        }
    }

    func score() -> Int {
        return game.score
    }

    func themeName() -> String {
        return themes.currentTheme.name
    }

    func getBackgroundColor() -> Color {
        let color = themes.currentTheme.color
        switch color {
        case "red":
            return Color.red
        case "yellow":
            return Color.yellow
        case "blue":
            return Color.blue
        case "green":
            return Color.green
        case "black":
            return Color.black
        case "gray":
            return Color.gray
        default:
            return Color.black
        }
    }
}

