//
//  helper_func.swift
//  final_1
//
//  Created by Feng Qi on 10/31/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//
// helper_func class
// to store some reusable functions

import Foundation
import UIKit

class helper_func{
    // resize image to fit uiimage frame
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth/image.size.width
        let newheight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newheight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newheight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}


