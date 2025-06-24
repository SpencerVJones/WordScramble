//  WordsListView.swift
//  WordScramble
//  Created by Spencer Jones on 6/24/25

import SwiftUI

struct WordsListView: View {
    @ObservedObject var viewModel: ViewModel

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !viewModel.usedWords.isEmpty {
                HStack {
                    Text("Found Words")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal, 4)
                
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.usedWords, id: \.self) { word in
                            wordRow(word: word)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxHeight: 300)
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "text.magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("No words found yet")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("Start typing to find words!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            }
        }
    }
    
    @ViewBuilder
    private func wordRow(word: String) -> some View {
        HStack(spacing: 12) {
            // Length indicator
            ZStack {
                Circle()
                    .fill(viewModel.colorForWordLength(word.count))
                    .frame(width: 32, height: 32)
                
                Text("\(word.count)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            // Word
            Text(word.uppercased())
                .font(.system(.body, design: .monospaced))
                .fontWeight(.medium)
            
            Spacer()
            
            // Score
            Text("+\(viewModel.scoreForWord(word))")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 1, y: 1)
        .contextMenu {
            Button("Remove Word", role: .destructive) {
                viewModel.removeWord(word)
            }
        }
    }
}

#Preview {
    WordsListView(viewModel: ViewModel())
}
