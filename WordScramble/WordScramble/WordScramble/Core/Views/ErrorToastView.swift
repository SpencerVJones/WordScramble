//  ErrorToastView.swift
//  WordScramble
//  Created by Spencer Jones on 6/24/25

import SwiftUI

struct ErrorToastView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            if viewModel.showingError {
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text(viewModel.errorTitle)
                            .font(.headline)
                        Spacer()
                        Button("×") {
                            withAnimation {
                                viewModel.showingError = false
                            }
                        }
                        .font(.title2)
                        .foregroundColor(.secondary)
                    }
                    
                    Text(viewModel.errorMessage)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
                .padding(.horizontal, 20)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            Spacer()
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.showingError)
    }
}

#Preview {
    ErrorToastView(viewModel: ViewModel())
}
