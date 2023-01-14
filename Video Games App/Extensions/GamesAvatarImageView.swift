//
//  GamesAvatarImageView.swift
//  Video Games App
//
//  Created by Mikail Baykara on 13.01.2023.
//

import Foundation
import UIKit

// gets the games' images by doing networking

extension UIImageView{
    
    func downloadImage(from urlString: String){
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self]data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            guard let _ = response else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
