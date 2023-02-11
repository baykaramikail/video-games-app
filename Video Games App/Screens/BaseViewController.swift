//
//  BaseViewController.swift
//  Video Games App
//
//  Created by Mikail Baykara on 10.12.2022.
//

import UIKit

class BaseViewController: UIViewController{
    
    @IBOutlet var GamesCollectionView: UICollectionView!
    @IBOutlet var GamesColViewSuperview: UIView!
    @IBOutlet var pageCollectionView: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    lazy private var originalConstraints = view.constraints
    lazy private var newConstraints: [NSLayoutConstraint] = []
    
    var networkManager = NetworkManager()
    var page = 1
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getGames(page: page)
        networkManager.delegate = self
        GamesCollectionView.delegate = self
        GamesCollectionView.dataSource = self
    
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        
        navigationItem.searchController = searchController
        //searchController.delegate = self
        searchController.searchBar.delegate = self
        
        GamesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = false
        
        startTimer()
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
            return CGSize(width: 360, height: 75)
        }else{
            return CGSize(width: 382, height: 210)
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
    
    // lets pageCollectionView to move next cell automatically.
    
    func startTimer() {
       _ =  Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }

    @objc func scrollAutomatically(_ timer1: Timer) {

        if let coll  = pageCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < firstThreeGames.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)

                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
            }
        }
    }
    
    
}

// Conforms network manager delegate.
extension BaseViewController: NetworkManagerDelegate{
    
    func getGames(model: [GameModel]) {
        
        gamesCopy += model
        games = gamesCopy
        firstThreeGames = Array(model[0...2])
        DispatchQueue.main.async {
            self.pageCollectionView.reloadData()
            self.GamesCollectionView.reloadData()
        }
    }
}


extension BaseViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        pageCollectionView.isHidden = true
        pageController.isHidden = true
        newConstraints = [
            GamesColViewSuperview.topAnchor.constraint(equalTo: self.view.topAnchor),
            GamesColViewSuperview.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            GamesColViewSuperview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            GamesColViewSuperview.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]
        NSLayoutConstraint.activate(newConstraints)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            games = gamesCopy
            self.GamesCollectionView.reloadData()
        }
        if searchText.count >= 3{
            games = []
            for game in gamesCopy{
                if game.name.uppercased().contains(searchText.uppercased()){
                    games.append(game)
                }
            }
            self.GamesCollectionView.reloadData()
        }
    }
    
   func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       pageCollectionView.isHidden = false
       pageController.isHidden = false
       view.removeConstraints(newConstraints)
       view.addConstraints(originalConstraints)
       games = gamesCopy
       self.GamesCollectionView.reloadData()
   }
    
}


