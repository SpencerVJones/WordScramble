//  ActionButtonsView.swift
//  WordScramble
//  Created by Spencer Jones on 6/24/25

import SwiftUI

struct ActionButtonsView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack(spacing: 16) {
            Button(action: viewModel.startGame) {
                HStack {
                    Image(systemName: "shuffle")
                    Text("New Word")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(12)
            }
            
            Button(action: viewModel.restartGame) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Restart")
                }
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue, lineWidth: 1)
                )
            }
        }
    }
}

#Preview {
    ActionButtonsView(viewModel: ViewModel())
}
