//
//  StringExtension.swift
//  Video Games App
//
//  Created by Mikail Baykara on 14.01.2023.
//

import Foundation

// removes html tags from a string

extension String{
    var removeHTMLtags : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
