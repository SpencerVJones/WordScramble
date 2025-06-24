//  InputSectionView.swift
//  WordScramble
//  Created by Spencer Jones on 6/24/25

import SwiftUI

struct InputSectionView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        
        
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
                    .font(.title3)
                
                TextField("Enter your word...", text: $viewModel.newWord)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.title3)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                if !viewModel.newWord.isEmpty {
                    Button(action: { viewModel.newWord = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
        }
    }
}
#Preview {
    InputSectionView(viewModel: ViewModel())
}
