//
//  SignUpViewModel.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/10/16.
//

import Firebase

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var isSignedUp: Bool = false

    init() {
        // アプリ起動時にFirebaseからサインイン状態を確認
        if let _ = Auth.auth().currentUser {
            self.isSignedUp = true
        } else {
            self.isSignedUp = false
        }
    }

    func signUp(completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isSignedUp = true
                completion()  // サインアップ成功時にクロージャを呼び出す
            }
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.isSignedUp = true
                completion()
            }
        }
    }
}

