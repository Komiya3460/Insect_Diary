import SwiftUI

struct IntroductionView: View {
    @State private var navigateToMainTab = false
    @State private var navigateToTermsOfUse = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Text("はじめに")
                    .padding(.top, 5)
                
                Text("ダウンロードいただき、ありがとうございます。「昆虫日記」をご利用いただくには、利用規約に同意していただく必要があります。「利用規約」をご確認の上、「同意」ボタンを押して、ご利用ください。")
                    .padding(.top, 50)

                Button(action: {
                    navigateToMainTab = true
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
            .navigationBarHidden(true) 
            .navigationDestination(isPresented: $navigateToMainTab) {
                MainTabView()
                    .navigationBarHidden(false)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $navigateToTermsOfUse) {
                TermsOfUseView()
            }
        }
    }
}

#Preview {
    IntroductionView()
}
