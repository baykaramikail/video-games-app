//
//  File.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.12.2022.
//

import Foundation
import UIKit

struct Game: Equatable{
    var favorited = false
    var placeInArray = 0
    var favGamePlace = 0
    
    let banner: UIImage?
    let name: String
    let rating: String
    let release: String
    let description: String
}

