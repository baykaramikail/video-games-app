//
//  ScreenshotsVC.swift
//  Video Games App
//
//  Created by Mikail Baykara on 2.06.2023.
//

import UIKit
import SDWebImage

class ScreenshotsVC: UITableViewController {

    @IBOutlet var screenshotsTableView: UITableView!
    
    var screenshotsArray = [Images]()
    var gameId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager().getScreenshots(id: gameId) { [weak self] screenshots in
            self?.screenshotsArray = screenshots
            DispatchQueue.main.sync {
                self?.screenshotsTableView.reloadData()
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width * 0.55
    }
    
}



// MARK: - Table view data source
extension ScreenshotsVC{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return screenshotsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "screenshotCell", for: indexPath) as! ScreenhotsTableViewCell
        let url = screenshotsArray[indexPath.row].image
        cell.screenshotImageView.sd_setImage(with: URL(string: url))

        // Configure the cell...

        return cell
    }

}
