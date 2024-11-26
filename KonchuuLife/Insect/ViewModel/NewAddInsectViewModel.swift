//
//  NewAddInsectViewModel.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/11/02.
//

import UIKit

class NewAddInsectViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var size: String = ""
    @Published var image: UIImage? = nil
    
    func saveInsect(to viewModel: MyInsectViewModel) {
        viewModel.addInsect(name: name, size: size, date: date, image: image)
        print("昆虫情報受け取ってる\(name)\(size)\(date)")
    }
}
