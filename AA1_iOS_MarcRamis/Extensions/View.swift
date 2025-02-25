//
//  View.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 4/5/23.
//

import Foundation
import UIKit

extension UIView{
    @GKInspectable var cornerRadius: CGFloat{
        
        get {
            return layer.cornerRadius
        }
        
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
