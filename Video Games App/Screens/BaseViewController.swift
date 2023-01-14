//
//  BaseViewController.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.12.2022.
//

import UIKit

class BaseViewController: UIViewController{
    
    @IBOutlet var GamesCollectionView: UICollectionView!
    var networkManager = NetworkManager()
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
            networkManager.delegate = self
            GamesCollectionView.delegate = self
            GamesCollectionView.dataSource = self
            GamesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            
        networkManager.getGames(page: page)
    }
    
    
    // Perform segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsGameVC, let game = sender as? GameModel{
            detailsVC.gameToShow = game
        }
    }
    
}

// collection view stuff. number of rows etc
extension BaseViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCollectionViewCell
        let game = games[indexPath.item]
        cell.banner.downloadImage(from: game.backgroundImage)
        cell.title.text = game.name
        cell.rating.text = String(game.rating)
        cell.released.text = game.released
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = games[indexPath.item]
        performSegue(withIdentifier: "showDetails", sender: selectedGame)
    }
    
    
    // requests new network call when the last cell is shown in the collection view
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == games.count - 1 ) {
           page += 1
             networkManager.getGames(page: page)
         }
    }
    
}

// gives collection view's cells its sizes
extension BaseViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 80)
    }
}


extension BaseViewController: NetworkManagerDelegate{
    
    func getGames(model: [GameModel]) {
        DispatchQueue.main.async {
            games += model
            self.GamesCollectionView.reloadData()
        }
    }
}



