//
//  FavoriteGamesCollectionVC.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.12.2022.
//

import UIKit



class FavoriteGamesCollectionVC: UICollectionViewController {
    @IBOutlet var FavoriteGamesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteGamesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()

    }
    
    // this code reloads the favorite collection view every time when favorites vc opened
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.FavoriteGamesCollectionView.reloadData()
        
    }
    
    
    // performs seque
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsGameVC, let game = sender as? GameModel{
            detailsVC.gameToShow = game
        }
    }
    
    // favorite collection view stuff. number of rows etc
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteGameCell", for: indexPath) as! FavoriteGamesCollectionViewCell
        let game = favoriteGames[indexPath.item]
        
        cell.banner.downloadImage(from: game.backgroundImage)
        cell.banner.layer.cornerRadius = 20
        cell.title.text = game.name
        cell.rating.text = String(game.rating)
        cell.released.text = game.released
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGame = favoriteGames[indexPath.item]

        performSegue(withIdentifier: "showDetails", sender: selectedGame)
    }
}

// this code gives favorite collection view's cells its sizes
extension FavoriteGamesCollectionVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 80)
    }
}
