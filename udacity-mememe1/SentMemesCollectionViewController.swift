//
//  RootViewController.swift
//  udacity-mememe1
//
//  Created by Edno Fedulo on 31/03/18.
//  Copyright © 2018 Fedulo. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(CreateNewMeme))
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        collectionView?.reloadData()
    }

    @objc func CreateNewMeme(){
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateMemeViewController") as! ViewController
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! SentMemesCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.sentMemeImageView.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[(indexPath as NSIndexPath).row]
        
        let imageViewController = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        imageViewController.meme = meme
        
        navigationController?.pushViewController(imageViewController, animated: true)
    }

}
