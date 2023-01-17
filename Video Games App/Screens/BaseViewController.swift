//
//  BaseViewController.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.12.2022.
//

import UIKit

class BaseViewController: UIViewController{
    
    @IBOutlet var GamesCollectionView: UICollectionView!
    @IBOutlet var pageCollectionView: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    
    var networkManager = NetworkManager()
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getGames(page: page)
        networkManager.delegate = self
        GamesCollectionView.delegate = self
        GamesCollectionView.dataSource = self
    
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        
        GamesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
       
    }
    
    
    // Perform segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsGameVC, let game = sender as? GameModel{
            detailsVC.gameToShow = game
        }
    }
    
}


// collection view stuff. number of rows etc
extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.pageCollectionView{
            return firstThreeGames.count
        }else if collectionView == self.GamesCollectionView{
            return games.count
        }else{ return 0 }
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.pageCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageControlCollectionViewCell", for: indexPath ) as! PageVCCollectionViewCell
            let game = firstThreeGames[indexPath.item]
            cell.pageImage.downloadImage(from: game.backgroundImage)
            cell.pageImage.layer.cornerRadius = 20
            cell.pageName.text = game.name
            return cell
            
        }else if collectionView == self.GamesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCollectionViewCell
            let game = games[indexPath.item]
            cell.banner.downloadImage(from: game.backgroundImage)
            cell.banner.layer.cornerRadius = 20
            cell.title.text = game.name
            cell.rating.text = String(game.rating)
            cell.released.text = game.released
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.pageCollectionView{
            let selectedGame = firstThreeGames[indexPath.item]
            performSegue(withIdentifier: "showDetails", sender: selectedGame)
        }else {
            let selectedGame = games[indexPath.item]
            performSegue(withIdentifier: "showDetails", sender: selectedGame)
        }
    }
}


extension BaseViewController: UICollectionViewDelegateFlowLayout{
    
    // aligning the collection view cells in the middle
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let cellWidth: CGFloat = 382
            let numberOfCells = floor(view.frame.size.width / cellWidth)
            let edgeInsets = (view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
        }
    
    // gives collection view's cells its sizes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.GamesCollectionView{
            return CGSize(width: 360, height: 80)
        }else{
            return CGSize(width: 382, height: 212)
        }
    }
    
    // requests new network call when the last cell is shown in the collection view
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == games.count - 1 ) {
           page += 1
             networkManager.getGames(page: page)
         }
        pageController.currentPage = indexPath.row
    }
}

// Conforms network manager delegate
extension BaseViewController: NetworkManagerDelegate{
    
    func getGames(model: [GameModel]) {
        DispatchQueue.main.async {
            games += model
            firstThreeGames = Array(games[0...2])
            
            self.pageCollectionView.reloadData()
            self.GamesCollectionView.reloadData()
        }
    }
}



