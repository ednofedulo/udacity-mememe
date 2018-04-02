//
//  MemeObject.swift
//  udacity-mememe1
//
//  Created by Edno Fedulo on 01/04/18.
//  Copyright © 2018 Fedulo. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    
    init(topText: String!, bottomText: String!, originalImage: UIImage!, memedImage: UIImage!) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
