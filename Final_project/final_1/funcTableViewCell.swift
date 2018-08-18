//
//  funcTableViewCell.swift
//  final_1
//
//  Created by Feng Qi on 10/30/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//
// Table View Cell

import UIKit
protocol TableViewCellDelegate{
    func delete_action(cell: funcTableViewCell)
}

class funcTableViewCell: UITableViewCell{

    @IBOutlet weak var express_field: UILabel!
    @IBOutlet weak var log_image: UIImageView!
    @IBOutlet var btn_delete: UIButton!
    
    var delegate: TableViewCellDelegate?
 
    override func awakeFromNib() {
        super.awakeFromNib()
        log_image.isUserInteractionEnabled = true
        log_image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnImage(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // initialize delegate
    @IBAction func delete_action(_ sender: Any) {
        delegate?.delete_action(cell: self)
    }
    
    var retapped = false
//    var introduction: UILabel!
    // tap gesture on log_image
    @objc func tapOnImage(_ sender: UITapGestureRecognizer){
        /**
        let introduction = UILabel(frame: CGRect(x: 0, y: self.frame.size.height/2-15, width: self.frame.size.width, height: 30))

        if let idx = FuncDatabase.sharedInstance.image_name_db.index(of: express_field.text!) {
            introduction.text = FuncDatabase.sharedInstance.description_db[idx]
        }else{
            introduction.text = ""
        }

        introduction.textAlignment = .center
        introduction.tag = 100
        introduction.font = UIFont(name: "Avenir Book", size: 25)
        */
        
        let introduction = UILabel(frame: CGRect(x: 20, y: self.frame.size.height/2-15, width: self.frame.size.width - 40, height: 30))
        if let idx = FuncDatabase.sharedInstance.image_name_db.index(of: express_field.text!) {
            introduction.text = FuncDatabase.sharedInstance.description_db[idx]
        }else{
            introduction.text = ""
        }
        introduction.textAlignment = .center
        introduction.tag = 100
        introduction.font = UIFont(name: "Avenir Book", size: 25)
        
        // first tap
        if(!retapped){
            retapped = true
            log_image.alpha = 0.3
            self.addSubview(introduction)
        }else{
            retapped = false
            if let viewWithTag = self.viewWithTag(100){
                viewWithTag.removeFromSuperview()
            }
            log_image.alpha = 1
        }
    }
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        if textView.tag == 0 {
//            introduction.isEnabled = true
//            textView.tag = 1
//        }
//
//        return true
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if (introduction.text?.isEmpty)! {
//            introduction.isHidden = false
//            textView.tag = 0
//        }
//    }
}
