//
//  UserDefaultsService.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/11/02.
//

import Foundation

final class UserDefaultsService {
    static let userDefaults = UserDefaults.standard
    
    static func saveInsect(_ insect: [Insect]) {
        if let encoded = try? JSONEncoder().encode(insect) {
            userDefaults.set(encoded, forKey: "InsectList")
        }
    }

    static func loadInsect() -> [Insect]? {
        if let savedData = userDefaults.data(forKey: "InsectList"),
           let decoded = try? JSONDecoder().decode([Insect].self, from: savedData) {
            return decoded
        }
        return nil
    }
    
    static let isStartKey = "IsStartKey"
    static func setIsStartKey(value: Bool) {
            userDefaults.set(value, forKey: isStartKey)
        }
        
        static func getIsStartKey() -> Bool {
            return userDefaults.bool(forKey: isStartKey)
        }
    }


