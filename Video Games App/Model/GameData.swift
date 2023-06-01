//
//  GameData.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.01.2023.
//

import Foundation

struct GameData: Codable{
    let results: [Results]
    
}

struct Results: Codable{
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    
    var favorite: Bool {
        return false
    }
}

