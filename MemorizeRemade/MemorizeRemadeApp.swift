//
//  MemorizeRemadeApp.swift
//  MemorizeRemade
//
//  Created by Stefano Morelli on 21/11/23.
//

import SwiftUI

@main
struct MemorizeRemadeApp: App {
    @StateObject var game = EmojiMemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            EmojiContentView(viewModel: game)
        }
    }
}
