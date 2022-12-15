//
//  BaseViewController.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.12.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet var GamesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        GamesCollectionView.delegate = self
        GamesCollectionView.dataSource = self
        GamesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()

    }
}

extension BaseViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCollectionViewCell
        let game = games[indexPath.item]
        
        cell.banner.image = game.banner
        cell.title.text = game.name
        cell.rating.text = game.rating
        cell.released.text = game.release
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsGameVC
        self.present(detailVC, animated: true, completion: nil)
        
    }
    
}


extension BaseViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 80)
    }
}
