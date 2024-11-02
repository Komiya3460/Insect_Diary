//
//  MyInsectViewmodel.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/11/02.
//

import UIKit

class MyInsectViewModel: ObservableObject {
    @Published var insect: [Insect] = []
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var size: String = ""
    @Published var image: UIImage? = nil
    
    func loadUserDefaults() {
        if let savedData = UserDefaultsService.loadInsect() {
            insect = savedData
        }
    }
    func addInsect() {
        let imageData = image?.pngData()
        let newInsect = Insect(name: name, size: size, date: date, imageData: imageData)
        insect.append(newInsect)
        UserDefaultsService.saveInsect(insect)
    }
}
