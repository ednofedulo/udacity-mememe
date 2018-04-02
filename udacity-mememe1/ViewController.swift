//
//  ViewController.swift
//  udacity-mememe1
//
//  Created by Edno Fedulo on 11/02/18.
//  Copyright © 2018 Fedulo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: outlets
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var pickedImageView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //MARK: TextField Attributes
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -4.0]
    
    let textFieldDelegate = TextFieldDelegate()
    
    //MARK: Meme Struct
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = pickedImageView.image != nil
        
        configureTextField(textField: topTextField)
        configureTextField(textField: bottomTextField)
        
        subscribeToKeyboardNotifications()
    }
    
    func configureTextField(textField: UITextField) {
        self.view.bringSubview(toFront: textField)
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = textFieldDelegate
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        pickedImageView.image = (editedImage != nil ? editedImage : originalImage)
        shareButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func pickAnImage(_ sender:Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = false
        pickerController.delegate = self
        
        if (sender as! UIBarButtonItem).tag == 0 {
            pickerController.sourceType = .camera
        } else {
            pickerController.sourceType = .photoLibrary
        }
        
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.save(memedImage: memedImage)
                self.dismiss()
            }
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func save(memedImage: UIImage) {
        
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: pickedImageView.image!, memedImage: memedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        toggleBars()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toggleBars()
        
        return memedImage
    }
    
    func toggleBars(){
        
        self.navigationBar.isHidden = !self.navigationBar.isHidden
        self.toolBar.isHidden = !self.toolBar.isHidden
    }
    
    //MARK: Keyboard events
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_notification:Notification){
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss()
    }
    
    func dismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}

