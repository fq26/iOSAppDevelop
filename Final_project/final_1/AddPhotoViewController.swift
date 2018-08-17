//
//  AddPhotoViewController.swift
//  final_1
//
//  Created by Feng Qi on 10/29/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//
// This is view controller class for adding photo
// take from photo library or from camera

import Foundation
import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var original_w: CGFloat?
    var original_h: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        original_w = imgDisplay.frame.width
        original_h = imgDisplay.frame.height
        btn_upload.isHidden = false
        btn_discard.isHidden = false

        add_name_line.isHidden = false
        add_name.isHidden = false
        description_content.isHidden = false
        description_line.isHidden = false

        description_content.delegate = self
        add_name.delegate = self
        
        add_name.addTarget(self, action: #selector(is_unique_name), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var warning_for_name: UILabel!
    
    // check whether the name is unique
    @objc func is_unique_name() -> Bool{
        if(FuncDatabase.sharedInstance.image_name_db.contains(add_name.text!)){
            warning_for_name.isHidden = false
            return false
        }else{
            warning_for_name.isHidden = true
            return true
        }
    }
    
    // return keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // dismiss keyboard when tapping outside testfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    @IBOutlet var btn_from_gallery: UIButton!
    @IBOutlet var btn_from_take: UIButton!
    @IBOutlet var imgDisplay: UIImageView!
    @IBOutlet var btn_upload: UIButton!
    @IBOutlet var btn_discard: UIButton!
    
    // get from library
    @IBAction func get_from_gallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // get from camera
    // have tested on physical device
    @IBAction func get_from_camera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var add_name_line: UILabel!
    @IBOutlet var add_name: UITextField!
    @IBOutlet var description_line: UILabel!
    @IBOutlet var description_content: UITextField!
    
    // show in UIImage frame
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgDisplay.image = resize_Image(image: image, newWidth: imgDisplay.frame.width, oldheight: imgDisplay.frame.height)
        }
        picker.dismiss(animated: true, completion: nil)
        
        btn_upload.isEnabled = true
        btn_discard.isEnabled = true
        add_name.isEnabled = true
        description_content.isEnabled = true
        
        add_name_line.font = UIFont(name: "Noteworthy", size:20)
        description_line.font = UIFont(name: "Noteworthy", size:20)
        
    }
    
    // TODO
    // click "upload" button
    @IBAction func upload_action(_ sender: UIButton) {
        if(imgDisplay.image != nil && description_content.text != "" && add_name.text != ""){
            // insert at first place
            FuncDatabase.sharedInstance.image_name_db.insert(add_name.text!, at: 0)
            FuncDatabase.sharedInstance.description_db.insert(description_content.text!, at: 0)
            FuncDatabase.sharedInstance.image_db.insert(imgDisplay.image!, at: 0)
            refresh()
            // redirect to TableVC
            self.tabBarController?.selectedIndex = 2

        }else{
            print("plz fill out all the content!")
        }
    }
    
    // click "discard" button
    @IBAction func discard_action(_ sender: UIButton) {
        if(btn_discard.isEnabled){
            refresh()
        }
    }
    
    // refresh the AddPhotoViewController
    func refresh(){
        UIGraphicsBeginImageContext(CGSize(width: original_w!, height: original_h!))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imgDisplay.image = newImage
        
        description_content.text? = ""
        add_name.text? = ""
        
        btn_upload.isEnabled = false
        btn_discard.isEnabled = false
    }
    
    func resize_Image(image: UIImage, newWidth: CGFloat, oldheight: CGFloat) -> UIImage? {
        let scale = newWidth/image.size.width
        let newheight = image.size.height * scale
        let new_w = newWidth
        UIGraphicsBeginImageContext(CGSize(width: new_w, height: newheight))
        image.draw(in: CGRect(x: 0, y: 0, width: new_w, height: newheight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
