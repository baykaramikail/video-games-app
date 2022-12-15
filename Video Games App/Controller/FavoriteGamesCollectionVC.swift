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
            warningLabel.text = "Please favor the games you like to see them here."
            warningLabel.translatesAutoresizingMaskIntoConstraints = false
            warningLabel.lineBreakMode = .byWordWrapping
            warningLabel.numberOfLines = 0
            warningLabel.textAlignment = .center
            self.view.addSubview(warningLabel)
            warningLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            warningLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }

    

   
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
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsGameVC
        self.present(detailVC, animated: true, completion: nil)
    }
    
}


extension FavoriteGamesCollectionVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 80)
    }
}
