//
//  DetailsGameVC.swift
//  Video Games App
//
//  Created by Mikail Baykara on 15.12.2022.
//

import UIKit

class DetailsGameVC: UIViewController {
    
    var gameToShow: GameModel!
    let networkManager = NetworkManager()

    @IBOutlet var banner: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var released: UILabel!
    @IBOutlet var metacriticRate: UILabel!
    @IBOutlet var gameDescription: UILabel!
    @IBOutlet var likeButtonSuperview: CustomView!
    @IBOutlet var likeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.banner.downloadImage(from: gameToShow.backgroundImage)
        self.banner.layer.cornerRadius = 25
        self.name.text = gameToShow.name
        self.released.text = "Release date: \(gameToShow.released)"
        self.metacriticRate.text = "Rating: \(gameToShow.rating)"
        self.networkManager.getGameDescription(id: gameToShow.id, label: gameDescription)
        
        
        if gameToShow.favorited == true{
            self.likeButton.tintColor = .green
            self.likeButtonSuperview.backgroundColor = .white
        }else{
            self.likeButton.tintColor = .white
            self.likeButtonSuperview.backgroundColor = .black
        }
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        if self.likeButton.tintColor == .white{
            self.likeButton.tintColor = .green
            self.likeButtonSuperview.backgroundColor = .white
            for var game in games{
                if game.id == gameToShow.id{
                    game.favorited = true
                    favoriteGames.insert(game, at: 0)
                    break
                }
            }
        }else{
            self.likeButton.tintColor = .white
            self.likeButtonSuperview.backgroundColor = .black
            for var game in games{
                if game.id == gameToShow.id{
                    game.favorited = false
                    favoriteGames = favoriteGames.filter { game in
                        game.id != gameToShow.id
                    }
                    break
                }
            }
        }
    }
    
    @IBAction func closeDetailPagebuttonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


