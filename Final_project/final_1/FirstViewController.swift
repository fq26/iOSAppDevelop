//
//  FirstViewController.swift
//  final_1
//
//  Created by Feng Qi on 10/28/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//
// this is home page VC swift file (initial screen)

import UIKit
class FirstViewController: UIViewController ,UITabBarControllerDelegate, backDelegate {
    @IBOutlet var profile_view: UIView!
    @IBOutlet weak var profile_intro: UILabel!
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var moment_count: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // initialized profile
        setupProfile(image: FuncDatabase.sharedInstance.profile_image, intro: FuncDatabase.sharedInstance.profile_info[2], posts: FuncDatabase.sharedInstance.image_name_db.count)
        // update post_count variable
        // when SecondViewController btn_delete is clicked
        NotificationCenter.default.addObserver(self, selector: #selector(update_post_count), name: NSNotification.Name(FunctionsDBChangeNotification), object: nil )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func update_post_count(){
        let posts = FuncDatabase.sharedInstance.image_db.count
        moment_count?.text = "POSTS : " + String(posts)
    }
    
    // profile image uploading
    func setupProfile(image: UIImage, intro: String, posts: Int){
        // setup profile image
        profile_image.image = helper_func.resizeImage(image: image, newWidth: profile_image.frame.size.width)
        profile_image.contentMode = .scaleAspectFit
        profile_image.layer.cornerRadius = 25
        profile_image.clipsToBounds = true
        
        // setup posts count
        moment_count?.text = "POSTS : " + String(posts)
        
        // setup profile introduction
        profile_intro.frame = CGRect(x: 40, y: profile_image.frame.height + profile_image.frame.size.height + 50 , width: UIScreen.main.bounds.width-80, height: 60)
        profile_intro.font = UIFont(name: "HelveticaNeue-UltraLight", size: 20)
        profile_intro.adjustsFontSizeToFitWidth = true
        profile_intro.minimumScaleFactor = 0.7
        profile_intro.numberOfLines = 0
        profile_intro.text! = intro
    }
    
    // update FirstViewController when profile is updated
    func sendback(updated_image: UIImage, updated_user_name: String, updated_gender: String, updated_intro: String) {
        profile_image.image = updated_image
        if updated_intro != "" {
            profile_intro.text = updated_intro
            FuncDatabase.sharedInstance.profile_info[2] = updated_intro
        }
        FuncDatabase.sharedInstance.profile_info[0] = updated_user_name
        FuncDatabase.sharedInstance.profile_info[1] = updated_gender
        FuncDatabase.sharedInstance.profile_image = updated_image
    }
    
    // pass data between firstVC and settingsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is settingsViewController {
            let vc = segue.destination as? settingsViewController
            vc?.passed_user_name = FuncDatabase.sharedInstance.profile_info[0]
            vc?.passed_image = profile_image.image!
            vc?.passed_gender = FuncDatabase.sharedInstance.profile_info[1]
            // send back to firstVC
            let ctrl = segue.destination as! settingsViewController
            ctrl.delegate = self
        }
    }
}
