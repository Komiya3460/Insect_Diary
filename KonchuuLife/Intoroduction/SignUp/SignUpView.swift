import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel  // viewModelを外部から渡す
    @State private var navigateToMainTab: Bool = false

    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("サインアップ") {
                viewModel.signUp() {
                    navigateToMainTab = true
                }
            }
            .padding()
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationDestination(isPresented: $navigateToMainTab) {
            MainTabView()
        }
        .padding()
    }
}


