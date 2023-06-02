//
//  Screenshot.swift
//  Video Games App
//
//  Created by Mikail Baykara on 2.06.2023.
//

import Foundation

struct Screenshot:Decodable{
    let results: [Images]
}

struct Images:Decodable{
    let image: String
}
