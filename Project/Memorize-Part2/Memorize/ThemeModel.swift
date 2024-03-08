//
//  ThemeModel.swift
//  Memorize
//
//  Created by Hui Hu on 3/6/24.
//

import Foundation

struct Theme {
    let name: String
    let emojis: [String]
    let color: String
    private(set) var numberOfPairs: Int = 3
    
    mutating func updateNumberOfPairs(_ newValue: Int) {
        numberOfPairs = min(newValue, emojis.count)
    }
}

struct ThemeModel {
    private var themes: [Theme]
    private var themeIndex: Int
    private(set) var currentTheme: Theme

    init(_ themeList: [Theme] = []) {
        self.themes = [
            Theme(name: "Emoji", emojis: ["😶", "😑", "🙃", "🫨", "🧐", "🥶", "🫠", "🤕"], color: "blue"),
            Theme(name: "Animal", emojis: ["🦋", "🪼", "🐡", "🦆", "🦑", "🦐", "🦔", "🦤"], color: "green"),
            Theme(name: "Play", emojis: ["⚾️", "⚽️", "🏈", "🏉", "🎾", "🏀", "🏐", "🥎"], color: "red"),
            Theme(name: "Moon", emojis: ["🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔"], color: "black"),
            Theme(name: "Food", emojis: ["🥐", "🥯", "🍞", "🧀", "🥞", "🧇", "🍔", "🥪"], color: "gray"),
            Theme(name: "Travel", emojis: ["🚒", "🚑", "🚌", "🚜", "🚂", "🚀", "🛥️", "✈️"], color: "yellow")
        ]
        if themeList.count > 0 {
            self.themes.append(contentsOf: themeList)
        }
        self.themeIndex = Int.random(in: 0..<themes.count)
        self.currentTheme = themes[themeIndex]
    }

    func getTheme() -> Theme {
        return currentTheme
    }

    mutating func updateTheme() {
        themeIndex = (themeIndex + Int.random(in: 0..<themes.count) + 1) % themes.count
        currentTheme = themes[themeIndex]
    }
}


