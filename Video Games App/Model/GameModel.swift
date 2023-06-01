//
//  File.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.12.2022.
//

import Foundation
import UIKit

struct GameModel: Codable, Equatable{
  
    var favorited = false
    
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double

}
