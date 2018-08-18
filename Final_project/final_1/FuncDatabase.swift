//
//  FuncDatabase.swift
//  final_1
//
//  Created by Feng Qi on 10/30/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//

import Foundation
import UIKit

let FunctionsDBChangeNotification = "FUNCTIONS_DB_CHANGED"

class FuncDatabase{
    static var sharedInstance = FuncDatabase()
    var profile_info = ["Sally", "Female", "Currently it is all about Maria~~"] {
        didSet{
            NotificationCenter.default.post(name: Notification.Name(FunctionsDBChangeNotification), object: self)
        }
    }
    var profile_image: UIImage = UIImage(named: "sally")!{
        didSet{
            NotificationCenter.default.post(name: Notification.Name(FunctionsDBChangeNotification), object: self)
        }
    }
    
    // image unique name db
    var image_name_db = ["maria_1", "maria_2", "maria_3", "maria_5"]{
        didSet {
            NotificationCenter.default.post(name: Notification.Name(FunctionsDBChangeNotification), object: self)
        }
    }
    
    // image description db
    var description_db = ["Maria is sleeping", "When Maria is lying", "Maria is so cute!", "Halloween Maria"] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(FunctionsDBChangeNotification), object: self)
        }
    }
    
    // image db
    var image_db :[UIImage?] = [nil,nil,nil,nil] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(FunctionsDBChangeNotification), object: self)
        }
    }
}
