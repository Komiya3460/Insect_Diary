//
//  ContentView.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/09/22.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.isSignedUp {
                MainTabView()
            } else {
                IntroductionView(viewModel: viewModel)  // viewModelを渡す
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView() // ナビゲーションバーを空にする
            }
        }
    }
}
