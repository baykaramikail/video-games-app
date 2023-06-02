//
//  ScreenhotsTableViewCell.swift
//  Video Games App
//
//  Created by Mikail Baykara on 2.06.2023.
//

import UIKit

class ScreenhotsTableViewCell: UITableViewCell {

    @IBOutlet var screenshotContainer: UIView!
    @IBOutlet var screenshotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.screenshotContainer.layer.cornerRadius = 40
        self.screenshotImageView.layer.cornerRadius = 40
    }


}
