//
//  CountryTVC.swift
//  ios proj
//
//  Created by Epita on 18/01/2022.
//

import UIKit

class CountryTVC: UITableViewCell {

    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryAlpha: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
