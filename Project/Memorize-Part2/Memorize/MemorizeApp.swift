//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Hui Hu on 3/1/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = GameViewModel()
    var body: some Scene {
        WindowGroup {
            MemoryGameView(viewModel: game)
        }
    }
}
