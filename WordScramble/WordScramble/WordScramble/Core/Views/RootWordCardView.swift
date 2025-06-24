//  RootWordCardView.swift
//  WordScramble
//  Created by Spencer Jones on 6/24/25

import SwiftUI

struct RootWordCardView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Make words from:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(viewModel.rootWord.uppercased())
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .tracking(4)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                        )
                )
        }
    }
}

#Preview {
    RootWordCardView(viewModel: ViewModel())
}
