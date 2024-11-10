import SwiftUI

struct MainTabView: View {
    @State private var navigationTitle = "My昆虫"
    @StateObject private var viewModel = MyInsectViewModel()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 200/255, green: 230/255, blue: 240/255, alpha: 1.0)
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .medium),
            .foregroundColor: UIColor.black
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.configureWithOpaqueBackground()
        let selectedColor = UIColor(red: 0/255, green: 100/255, blue: 100/255, alpha: 1.0)
        tabbarAppearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        tabbarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        
        let normalColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        tabbarAppearance.stackedLayoutAppearance.normal.iconColor = normalColor
        tabbarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]
        
        UITabBar.appearance().standardAppearance = tabbarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabbarAppearance
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                MyInsectView(viewModel: viewModel)
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("My昆虫")
                        }
                    }
                    .tag(1)
                    .onAppear {
                        navigationTitle = "My昆虫"
                    }
                
                InsectTweetView()
                    .tabItem {
                        VStack {
                            Image(systemName: "heart.fill")
                            Text("つぶやき")
                        }
                    }
                    .tag(2)
                    .onAppear {
                        navigationTitle = "つぶやき"
                    }
                
                NoticeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "gear")
                            Text("お知らせ")
                        }
                    }
                    .tag(3)
                    .onAppear {
                        navigationTitle = "お知らせ"
                    }
                
                InfoView() // 修正: スペルミスを修正
                    .tabItem {
                        VStack {
                            Image(systemName: "info.circle") // 適切なアイコンを使用
                            Text("Info")
                        }
                    }
                    .tag(4)
                    .onAppear {
                        navigationTitle = "Info"
                    }
            }
            .accentColor(Color.indigo)
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}
