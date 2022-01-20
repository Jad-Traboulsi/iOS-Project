//
//  CountryDetailsTVC.swift
//  ios proj
//
//  Created by Epita on 20/01/2022.
//

import UIKit

class CountryDetailsTVC: UITableViewCell {

    
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
