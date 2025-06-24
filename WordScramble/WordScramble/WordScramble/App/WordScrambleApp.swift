//  WordScrambleApp.swift
//  WordScramble
//  Created by Spencer Jones on 6/23/25

import SwiftUI

@main
struct WordScrambleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
