import SwiftUI
import FirebaseAuth

struct InsectTweetView: View {
    @StateObject private var tweetViewModel = InsectTweetViewModel()  // StateObjectでViewModelを管理
    @State private var newTweetContent: String = ""
    @State private var newCommentContent: String = ""
    @State private var selectedTweetId: String? = nil
    @State private var navigationTweetView = false
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        // タブに戻るたびにViewModelをリセット
        _tweetViewModel = StateObject(wrappedValue: InsectTweetViewModel())
    }

    var body: some View {
        NavigationStack {
            VStack {
                List(tweetViewModel.tweets) { tweet in
                    VStack(alignment: .leading) {
                        Text(tweet.content)
                            .font(.body)
                        Text("Posted by \(tweet.userId)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(tweet.timestamp, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Text("👍 \(tweet.likes)")
                            Spacer()
                        }
                        .padding(.vertical, 4)
                        
                        if selectedTweetId == tweet.id {
                            ForEach(tweet.comments) { comment in
                                VStack(alignment: .leading) {
                                    Text(comment.content)
                                        .font(.subheadline)
                                    Text("Commented by \(comment.userId)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(comment.timestamp, style: .time)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                            
                            TextField("Add a comment...", text: $newCommentContent)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: {
                                if !newCommentContent.isEmpty {
                                    tweetViewModel.addComment(to: tweet.id, content: newCommentContent, userId: Auth.auth().currentUser?.uid ?? "unknown")
                                    newCommentContent = ""
                                    selectedTweetId = nil
                                }
                            }) {
                                Text("Submit Comment")
                                    .foregroundColor(.blue)
                            }
                            .padding(.top, 4)
                        }
                        
                        Button(action: {
                            selectedTweetId = selectedTweetId == tweet.id ? nil : tweet.id
                        }) {
                            Text(selectedTweetId == tweet.id ? "Hide Comments" : "Show Comments")
                                .foregroundColor(.blue)
                                .font(.caption)
                        }
                        .padding(.top, 8)
                    }
                    .padding(.vertical, 8)
                }
                
                NavigationLink(destination: TweetPostView(tweetViewModel: tweetViewModel)) {
                    EmptyView()
                }
            }
            .navigationTitle("Tweets")
            .onAppear {
                tweetViewModel.fetchTweets()  // 画面表示ごとにfetchTweetsを呼び出す
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    tweetViewModel.fetchTweets()  // アクティブになるたびにデータをリロード
                }
            }
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            navigationTweetView = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                }
            )
            NavigationLink(destination: TweetPostView(tweetViewModel: tweetViewModel), isActive: $navigationTweetView) { EmptyView() }
        }
    }
}
