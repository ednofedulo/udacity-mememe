//
//  SentMemesTableViewController.swift
//  udacity-mememe1
//
//  Created by Edno Fedulo on 31/03/18.
//  Copyright © 2018 Fedulo. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController{

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(CreateNewMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        tableView.reloadData()
    }
    
    @objc func CreateNewMeme(){
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreateMemeViewController") as! ViewController
        
        self.present(viewController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath)
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText!) / \(meme.bottomText!)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let index = (indexPath as NSIndexPath).row
            memes.remove(at: index)
            (UIApplication.shared.delegate as! AppDelegate).memes = memes
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[(indexPath as NSIndexPath).row]
        
        let imageViewController = storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        imageViewController.meme = meme
        
        navigationController?.pushViewController(imageViewController, animated: true)
        
    }

}
