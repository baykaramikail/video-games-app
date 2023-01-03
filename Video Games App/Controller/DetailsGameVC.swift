//
//  DetailsGameVC.swift
//  Video Games App
//
//  Created by Mikail Baykara on 15.12.2022.
//

import UIKit

class DetailsGameVC: UIViewController {
    
    var gameToShow: Game?

    @IBOutlet var banner: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var released: UILabel!
    @IBOutlet var metacriticRate: UILabel!
    @IBOutlet var gameDescription: UILabel!
    @IBOutlet var likeButtonSuperview: CustomView!
    @IBOutlet var likeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.banner.image = gameToShow?.banner
        self.name.text = gameToShow?.name
        self.released.text = gameToShow?.release
        self.metacriticRate.text = gameToShow?.rating
        self.gameDescription.text = gameToShow?.description
        
        if gameToShow?.favorited == true{
            self.likeButton.tintColor = .green
            self.likeButtonSuperview.backgroundColor = .white
        }else{
            self.likeButton.tintColor = .white
            self.likeButtonSuperview.backgroundColor = .black
        }
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        self.likeButton.tintColor = .green
        self.likeButtonSuperview.backgroundColor = .white
        if gameToShow?.favorited == false{
            let index = gameToShow?.placeInArray
            games[index!].favorited = true
            gameToShow?.favorited = true
            if favoriteGames.contains(gameToShow!){return} else{favoriteGames.append(gameToShow!)}
            
        }else{
            self.likeButton.tintColor = .white
            self.likeButtonSuperview.backgroundColor = .black
            let index = gameToShow?.placeInArray
            games[index!].favorited = false
            gameToShow?.favorited = false
            let orderInFavGames = gameToShow?.favGamePlace
            favoriteGames.remove(at: orderInFavGames!)
        }
    }
}


