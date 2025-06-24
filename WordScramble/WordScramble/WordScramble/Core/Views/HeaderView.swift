//  HeaderView.swift
//  WordScramble
//  Created by Spencer Jones on 6/24/25

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("WordScramble")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Game #\(viewModel.gameNumber)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 24) {
                VStack(spacing: 2) {
                    Text("\(viewModel.score)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    Text("Score")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                VStack(spacing: 2) {
                    Text("\(viewModel.usedWords.count)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Text("Words")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
    }
}

#Preview {
    HeaderView(viewModel: ViewModel())
}
