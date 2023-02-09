//
//  ResultsVC.swift
//  Video Games App
//
//  Created by Mikail Baykara on 6.02.2023.
//

import UIKit

class ResultsVC: UIViewController {

    @IBOutlet var filteredGamesCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let filteredGamesCollectionView = filteredGamesCollectionView else { return }

        filteredGamesCollectionView.delegate = self
        filteredGamesCollectionView.dataSource = self
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsGameVC, let game = sender as? GameModel{
            detailsVC.gameToShow = game
        }
    }
}



extension ResultsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCollectionViewCell
        let game = filteredGames[indexPath.item]
        cell.banner.downloadImage(from: game.backgroundImage)
        cell.banner.layer.cornerRadius = 20
        cell.title.text = game.name
        cell.rating.text = String(game.rating)
        cell.released.text = game.released
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = filteredGames[indexPath.item]
        performSegue(withIdentifier: "showDetails", sender: selectedGame)
    }
}
