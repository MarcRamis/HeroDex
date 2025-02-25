//
//  HeroCollectionViewCell.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 4/5/23.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: MyImageView!
    
    @IBOutlet weak var itemName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
