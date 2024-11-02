//
//  MyInsectView.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/10/01.
//

import SwiftUI

struct MyInsectView: View {
    @ObservedObject private var myInsectViewModel = MyInsectViewModel()
    @State private var navigationToAddInsect = false
    private let formatter: DateFormatter
    
    init(viewModel: MyInsectViewModel) {
        self.myInsectViewModel = viewModel
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日(E)"
        formatter.locale = Locale(identifier: "ja_JP")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if myInsectViewModel.insect.isEmpty {
                        Text("昆虫がまだ登録されてません")
                        .font(.system(size: 24, weight: .bold))
                    } else {
                        ScrollView {
                            ForEach($myInsectViewModel.insect, id: \.id) { $insect in
                                NavigationLink(destination: InsecDetailsView(item: insect.name, insect: insect)) {
                                    HStack {
                                        if let imageData = insect.imageData,
                                           let image = UIImage(data: imageData) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(10)
                                        } else {
                                            Image("aquarium_icon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(10)
                                        }
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("\(insect.name)")
                                                .font(.headline)
                                            Text("サイズ: \(insect.size)")
                                                .font(.system(size: 10, weight: .light))
                                            Text("登録日: \(formatter.string(from: insect.date))")
                                                .font(.system(size: 10, weight: .light))
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                                    .padding(.horizontal)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                   
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            navigationToAddInsect = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: .medium))
                        }
                        .padding()
                        .background(Color(red: 173/255, green: 216/255, blue: 230/255))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .frame(width: 60, height: 60)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
                .onAppear {
                    myInsectViewModel.loadUserDefaults()
                }
                .navigationDestination(isPresented: $navigationToAddInsect) {
                    NewAddInsectView()
                }
            }
        }
    }
}
