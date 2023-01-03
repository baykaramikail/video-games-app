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
        
        if favoriteGames.isEmpty{
            let warningLabel = UILabel()
            warningLabel.text = "Your favorite games listed here."
            warningLabel.translatesAutoresizingMaskIntoConstraints = false
            warningLabel.numberOfLines = 0
            warningLabel.textAlignment = .center
            self.view.addSubview(warningLabel)
            warningLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            warningLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
    }
    // every time reloads the favorite collection view when favorites bar clicked
    override func viewWillAppear(_ animated: Bool) {
        self.FavoriteGamesCollectionView.reloadData()
    }
    // performs seque
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsGameVC, let game = sender as? Game{
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
        
        cell.banner.image = game.banner
        cell.title.text = game.name
        cell.rating.text = game.rating
        cell.released.text = game.release
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedGame = favoriteGames[indexPath.item]
        selectedGame.favGamePlace = favoriteGames.firstIndex(where: {$0 == selectedGame})!

        performSegue(withIdentifier: "showDetails", sender: selectedGame)
    }
}

// this code gives favorite collection view's cells its sizes
extension FavoriteGamesCollectionVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 80)
    }
}
