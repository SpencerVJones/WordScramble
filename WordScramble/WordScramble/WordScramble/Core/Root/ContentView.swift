//  ContentView.swift
//  WordScramble
//  Created by Spencer Jones on 6/23/25

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Header
            HeaderView(viewModel: viewModel)
            
            // Main Content
            VStack(spacing: 20) {
                // Root Word Display
                RootWordCardView(viewModel: viewModel)
                
                // Input Section
                InputSectionView(viewModel: viewModel)
                
                // Words List
                WordsListView(viewModel: viewModel)
                
                // Action Buttons
                ActionButtonsView(viewModel: viewModel)
            }
            .padding()
            .background(Color(.systemGroupedBackground))
        }
        .onSubmit(viewModel.addNewWord)
        .onAppear(perform: viewModel.startGame)
        .overlay(
            // Custom Error Toast
            ErrorToastView(viewModel: viewModel)
        )
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
