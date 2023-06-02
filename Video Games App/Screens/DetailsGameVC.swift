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
        self.banner.sd_setImage(with: URL(string: gameToShow.backgroundImage))
        self.banner.layer.cornerRadius = 20
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
    
    override func viewWillAppear(_ animated: Bool) {
        if favoriteGamesArray.contains(where: {$0.id == gameToShow.id}){
            self.likeButton.tintColor = .green
            self.likeButtonSuperview.backgroundColor = .white

        }
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        if self.likeButton.tintColor == .white{
            self.likeButton.tintColor = .green
            self.likeButtonSuperview.backgroundColor = .white
            
            for var game in gamesArray{
                if game.id == gameToShow.id{
                    game.favorited = true
                    favoriteGamesArray.insert(game, at: 0)
                    break
                }
            }
        }else{
            self.likeButton.tintColor = .white
            self.likeButtonSuperview.backgroundColor = .black
            favoriteGamesArray.removeAll(where: { $0 == gameToShow} )
        }
    }
        
        
        @IBAction func closeDetailPagebuttonClicked(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func showScreeshotsButtonClicked(_ sender: Any) {
        let id = self.gameToShow.id
        performSegue(withIdentifier: "showScreenshots", sender: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let targetVC = segue.destination as? ScreenshotsVC, let id = sender as? Int {
            targetVC.gameId = id
        }
    }
        
}
