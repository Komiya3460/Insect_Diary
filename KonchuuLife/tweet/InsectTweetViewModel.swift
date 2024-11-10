import Firebase
import FirebaseFirestore
import Combine

struct Tweet: Identifiable {
    let id: String
    let content: String
    let userId: String
    let timestamp: Date
    var likes: Int
    var comments: [Comment]
}

struct Comment: Identifiable {
    let id: String
    let content: String
    let userId: String
    let timestamp: Date
}

class InsectTweetViewModel: ObservableObject {
    @Published var tweets: [Tweet] = []
    private let db = Firestore.firestore()
    
    // つぶやきを取得する関数
    func fetchTweets() {
        db.collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching tweets: \(error)")
                    return
                }
                
                self.tweets = snapshot?.documents.compactMap { doc -> Tweet? in
                    let data = doc.data()
                    let tweetId = doc.documentID
                    guard let content = data["content"] as? String,
                          let userId = data["userId"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp,
                          let likes = data["likes"] as? Int else { return nil }
                    
                    return Tweet(id: tweetId, content: content, userId: userId, timestamp: timestamp.dateValue(), likes: likes, comments: [])
                } ?? []
                
                // 各つぶやきのコメントを取得
                self.fetchCommentsForTweets()
            }
    }
    
    // 各つぶやきに対するコメントを取得する関数
    private func fetchCommentsForTweets() {
        for (index, tweet) in tweets.enumerated() {
            db.collection("tweets").document(tweet.id).collection("comments")
                .order(by: "timestamp", descending: false)
                .getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Error fetching comments: \(error)")
                        return
                    }
                    
                    let comments = snapshot?.documents.compactMap { doc -> Comment? in
                        let data = doc.data()
                        guard let content = data["content"] as? String,
                              let userId = data["userId"] as? String,
                              let timestamp = data["timestamp"] as? Timestamp else { return nil }
                        
                        return Comment(id: doc.documentID, content: content, userId: userId, timestamp: timestamp.dateValue())
                    } ?? []
                    
                    self.tweets[index].comments = comments
                }
        }
    }
    
    // つぶやきを追加する関数
    func addTweet(content: String, userId: String) {
        let newTweet = [
            "content": content,
            "userId": userId,
            "timestamp": Timestamp(date: Date()),
            "likes": 0
        ] as [String: Any]
        
        db.collection("tweets").addDocument(data: newTweet) { error in
            if let error = error {
                print("Error adding tweet: \(error)")
            } else {
                print("Tweet successfully added!")
                self.fetchTweets() // 新しい投稿が追加されたら一覧を更新
            }
        }
    }
    
    // コメントを追加する関数
    func addComment(to tweetId: String, content: String, userId: String) {
        let comment = [
            "content": content,
            "userId": userId,
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        
        db.collection("tweets").document(tweetId).collection("comments").addDocument(data: comment) { error in
            if let error = error {
                print("Error adding comment: \(error)")
            } else {
                print("Comment successfully added!")
                self.fetchTweets() // コメントが追加されたら一覧を更新
            }
        }
    }
}
