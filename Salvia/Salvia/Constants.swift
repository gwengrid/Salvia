//
//  Constants.swift
//  Salvia
//
//  Created by gwendolyn weston on 4/13/16.
//  Copyright © 2016 gwendolyn weston. All rights reserved.
//

import UIKit

enum ImageAsset : String {
    case Serene = "Serene"
    case Congrats = "Congrats"
    case Add = "AddButton"
    case Check = "CheckButton"
    case X = "XButton"

}

extension UIImage {
    convenience init(asset: ImageAsset) {
        self.init(named: asset.rawValue)!
    }
}
