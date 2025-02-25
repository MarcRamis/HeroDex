//
//  HeroCellTableViewCell.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 28/4/23.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionTB: UITextView!
    
    @IBOutlet weak var heroImage: MyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
