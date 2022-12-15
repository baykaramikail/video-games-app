//
//  DetailsGameVC.swift
//  Video Games App
//
//  Created by Mikail Baykara on 15.12.2022.
//

import UIKit

class DetailsGameVC: UIViewController {

    @IBOutlet var banner: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var released: UILabel!
    @IBOutlet var metacriticRate: UILabel!
    @IBOutlet var likeButtonSuperview: CustomView!
    @IBOutlet var likeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        self.likeButtonSuperview.backgroundColor = .white
        self.likeButton.tintColor = .blue
    }
    
   

}
