//  ViewModel.swift
//  WordScramble
//  Created by Spencer Jones on 6/24/25.

import Foundation
import SwiftUI

// MARK: - ViewModel
class ViewModel: ObservableObject {
    @Published var usedWords = [String]()
    @Published var rootWord = ""
    @Published var newWord = ""
    @Published var score = 0
    @Published var gameNumber = 1
    
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    @Published var showingError = false
    
    // MARK: - Game Logic
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else {
            showError(title: "Word too short", message: "Words must be at least 3 letters long")
            return
        }
        
        guard answer != rootWord else {
            showError(title: "Same as root word", message: "You can't use the root word itself!")
            return
        }
        
        guard isOriginal(word: answer) else {
            showError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            showError(title: "Word not possible", message: "You can't spell that word from '\(rootWord.uppercased())'")
            return
        }
        
        guard isRealWord(word: answer) else {
            showError(title: "Word not recognized", message: "You can't just make up words!")
            return
        }
        
        // Add word and update score
        usedWords.insert(answer, at: 0)
        let wordScore = scoreForWord(answer)
        score += wordScore
        newWord = ""
    }
    
    func startGame() {
        // Try to load from bundle first
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
           let startWords = try? String(contentsOf: startWordsURL) {
            let allWords = startWords.components(separatedBy: "\n").filter { !$0.isEmpty }
            rootWord = allWords.randomElement() ?? "silkworm"
            return
        }
        
        // Fallback words if file not found
        let fallbackWords = ["silkworm", "telephone", "keyboard", "computer", "elephant", "rainbow", "birthday", "hospital", "adventure", "chocolate"]
        rootWord = fallbackWords.randomElement() ?? "silkworm"
    }
    
    func restartGame() {
        usedWords.removeAll()
        score = 0
        gameNumber += 1
        startGame()
        newWord = ""
    }
    
    func removeWord(_ word: String) {
        if let index = usedWords.firstIndex(of: word) {
            usedWords.remove(at: index)
            score -= scoreForWord(word)
        }
    }
    
    func clearNewWord() {
        newWord = ""
    }
    
    // MARK: - Scoring
    func scoreForWord(_ word: String) -> Int {
        let basePoints = word.count
        let lengthBonus = max(0, word.count - 4) * 2
        return basePoints + lengthBonus
    }
    
    func colorForWordLength(_ length: Int) -> Color {
        switch length {
        case 3...4: return .green
        case 5...6: return .blue
        case 7...8: return .purple
        default: return .red
        }
    }
    
    // MARK: - Validation
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    // MARK: - Error Handling
    private func showError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        
        // Auto-dismiss after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showingError = false
        }
    }
    
    func dismissError() {
        showingError = false
    }
}
