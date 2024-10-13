//
//  NoticeView.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/10/02.
//

import SwiftUI

struct NoticeView: View {
    let items = [
        (title: "バージョン1.3をリリース", content: "昆虫の画像を保存することができるようになりました。", Date: "2024年9月25日"),(title: "昆虫日記のアイコンが変わりました", content: "アプリのアイコンが変わりました。", Date: "2024年9月25日"),(title: "カレンダー機能の改善を行いました", content: "1ヶ月表示だけでなく1週間表示ができるようになりました", Date: "2024年9月1日"),(title: "Info画面の変更", content: "Info画面にお問い合わせ機能が実装されました", Date: "2024年8月28日"),(title: "Info画面の変更", content: "アプリレビュー機能の実装", Date: "2024年8月26日"),(title: "ダウンロードいただきありがとうございます", content: "昆虫日記をダウンロードいただきありがとうございます。これから保守、改善の方を行ってまいります。", Date: "2024年8月24日")
                 ]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(items, id: \.title) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(item.title)
                                .font(.system(size: 15, weight: .medium, design: .default))
                                .lineLimit(1)
                                .frame(width: 230, alignment: .leading)
                                .padding(.leading, 10)
                                .padding(.top, 8)
                            
                            Spacer()
                                
                            Text(item.Date)
                                .font(.system(size: 10, weight: .thin, design: .default))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing,10)
                                .padding(.top, 8)
                        }
                        Text(item.content)
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .padding(.top, 5)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 8)
                    }
                    .padding(.vertical, 5)
                    Divider()
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    NoticeView()
}
        
