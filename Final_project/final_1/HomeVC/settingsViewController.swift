//
//  settingsViewController.swift
//  final_1
//
//  Created by Feng Qi on 11/2/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//
// This is for setting VC directed by FirstVC object 'settings' button on navigation bar
// reference: http://theapplady.net/customize-a-text-view/

import UIKit
// customized delegate
protocol backDelegate {
    func sendback(updated_image: UIImage, updated_user_name: String, updated_gender: String, updated_intro: String)
}

class settingsViewController: UIViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerView
    @IBOutlet weak var genderPicker: UIPickerView!
    let myPicker = ["Female", "Male"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int ) -> String? {
        return myPicker[row]
    }
    
    @IBOutlet weak var gender: UITextField!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = myPicker[row]
    }
    
    @IBOutlet var profile_image: UIImageView!
    @IBOutlet var uesr_name: UITextField!
    @IBOutlet weak var Bio: UITextView!
    
    // variables sent from FirstViewController.swift
    var passed_user_name = ""
    var passed_image : UIImage!
    var passed_gender = ""
    
    var placeholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        Bio.delegate = self

        placeholder = UILabel(frame: CGRect(x: 4, y: 6, width: 200, height: 17))
        placeholder.textColor = UIColor.lightGray
        placeholder.font = UIFont(name: "HelveticaNeue-UltraLight", size: 17)
        placeholder.textAlignment = .left
        placeholder.text = "Describe yourself!"
        
        Bio.addSubview(placeholder)
        
        profile_image.image = passed_image
        profile_image.contentMode = .scaleAspectFit
        profile_image.layer.cornerRadius = 25
        profile_image.clipsToBounds = true
        
        uesr_name.text = passed_user_name
        view.addSubview(uesr_name)
        
        // genderPicker setting
        self.genderPicker.dataSource = self
        self.genderPicker.delegate = self
        gender.inputView = UIView()
        genderPicker.isHidden = true
        gender.text = passed_gender
    }
    
    @IBOutlet weak var btn_save: UIBarButtonItem!
    
    @IBAction func gender_input(_ sender: Any) {
        genderPicker.isHidden = false
    }
    
    @objc func keyboard(notification: NSNotification) {
        let info: Dictionary = notification.userInfo!
        var keyboardSize: CGSize!
        if let aValue = info[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            keyboardSize = aValue.cgRectValue.size
        }
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height - 22, 0.0)
        Bio.contentInset = contentInsets
        Bio.scrollIndicatorInsets = contentInsets
    }
    
    // allow scrolling
    func settingsViewController(scrollView: UIScrollView) {
        Bio.setNeedsDisplay()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.tag == 0 {
            placeholder.isHidden = true
            textView.tag = 1
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholder.isHidden = false
            textView.tag = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if let destination = segue.destination as? settingsViewController {
//            destination.delegate = self 
//        }
//    }
 
    // keyboard dismiss if 'enter' is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // dismiss keyboard when tapping outside testfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
        genderPicker.isHidden = true
    }
    
    // TODO
    // camera or photo
    @IBAction func change_profile(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose Photo", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "From Gallery", style: .default, handler: {
            alert -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Take Photo!", style: .default, handler: {
            alert -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profile_image.image = helper_func.resizeImage(image: image, newWidth: profile_image.frame.size.width)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    var delegate : backDelegate?
    
    // Save btn action
    @IBAction func back_to_firstVC(_ sender: Any) {
        delegate?.sendback(updated_image: profile_image.image!, updated_user_name: uesr_name.text!, updated_gender: gender.text!, updated_intro: Bio.text)
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popViewController(animated: true)
    }
}










