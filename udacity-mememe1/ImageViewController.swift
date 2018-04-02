//
//  ImageViewController.swift
//  udacity-mememe1
//
//  Created by Edno Fedulo on 01/04/18.
//  Copyright © 2018 Fedulo. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = meme.memedImage
    }

}
