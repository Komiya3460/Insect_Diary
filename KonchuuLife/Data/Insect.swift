//
//  Insect.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/11/02.
//
import UIKit


struct Insect: Identifiable, Codable {
    var id = UUID()
    var name: String
    var size: String
    var date: Date
    var imageData: Data?
}


