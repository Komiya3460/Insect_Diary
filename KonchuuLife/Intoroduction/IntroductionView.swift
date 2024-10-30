import SwiftUI

struct IntroductionView: View {
    @State private var navigateToTermsOfUse = false
    @State private var navigateToMainTab = false
    @State private var navigateToSignup = false
    @ObservedObject var viewModel = SignUpViewModel()  // SignUpViewModelを共有
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isSignedUp {
                    MainTabView()  // MainTabView を NavigationStack 内で表示
                } else {
                    VStack(alignment: .center, spacing: 20) {
                        Text("はじめに")
                            .padding(.top, 5)
                        
                        Text("ダウンロードいただき、ありがとうございます。「昆虫日記」をご利用いただくには、利用規約に同意していただく必要があります。「利用規約」をご確認の上、「同意」ボタンを押して、ご利用ください。")
                            .padding(.top, 50)
                        
                        Button(action: {
                            navigateToSignup = true
                        }) {
                            Text("同意する")
                                .frame(width: 100, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 50)
                        }
                        
                        Button(action: {
                            navigateToTermsOfUse = true
                        }) {
                            Text("利用規約")
                                .frame(width: 100, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 30)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 50)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(isPresented: $navigateToTermsOfUse) {
                        TermsOfUseView()
                    }
                    .navigationDestination(isPresented: $navigateToSignup) {
                        SignUpView(viewModel: viewModel)
                    }
                    .navigationDestination(isPresented: $navigateToMainTab) {
                        MainTabView()
                    }
                }
            }
        }
    }
}
