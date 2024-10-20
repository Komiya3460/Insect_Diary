//
//  MainTabView.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/09/22.
//

import SwiftUI

struct MainTabView: View {
    @State var navigationTitle = "My昆虫"
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 173/255, green: 246/255, blue: 220/255, alpha: 1.0)
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 10, weight: .medium),
            .foregroundColor: UIColor.black
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
            VStack {
                TabView {
                    MyInsectView()
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
                    CalendarContentView()
                        .tabItem {
                            VStack {
                                Image(systemName: "heart.fill")
                                Text("カレンダー")
                            }
                        }
                        .tag(2)
                        .onAppear {
                            navigationTitle = "カレンダー"
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
                    InfoVeiw()
                        .tabItem {
                            VStack {
                                Image(systemName: "heart.fill")
                                Text("Info")
                            }
                        }
                        .tag(4)
                        .onAppear {
                            navigationTitle = "Info"
                        }
                
                .accentColor(Color.indigo)
            }
            .navigationTitle(navigationTitle) // ナビゲーションタイトルを設定
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainTabView()
}
