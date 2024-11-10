//
//  TweetPostView.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/11/10.
//

import SwiftUI
import FirebaseAuth

struct TweetPostView: View {
    @ObservedObject var tweetViewModel: InsectTweetViewModel
    @State private var newTweetContent: String = ""

    var body: some View {
        VStack {
            TextField("What's happening?", text: $newTweetContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if !newTweetContent.isEmpty {
                    tweetViewModel.addTweet(content: newTweetContent, userId: Auth.auth().currentUser?.uid ?? "unknown")
                    newTweetContent = ""
                }
            }) {
                Text("Tweet")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationTitle("Create Tweet")
        .padding()
    }
}
