//
//  settingTextView.swift
//  final_1
//
//  Created by Feng Qi on 11/2/17.
//  Copyright © 2017 Feng Qi. All rights reserved.
//
// TextView setting

import UIKit

class settingTextView: UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.9
        self.layer.cornerRadius = 5.0
        self.font = UIFont(name: "HelveticaNeue-UltraLight", size: 17)
        self.tintColor = UIColor.lightGray   
    }
    
    // required
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(1.0)
        context.beginPath()
        let numberofLines = (self.contentSize.height + self.bounds.height) / self.font!.lineHeight
        let baselineoffset : CGFloat = 5.0
        for x in 1..<Int(numberofLines) {
            context.move(to: CGPoint(x: self.bounds.origin.x, y: self.font!.lineHeight * CGFloat(x) + baselineoffset))
            context.addLine(to: CGPoint(x: self.bounds.size.width, y: self.font!.lineHeight * CGFloat(x) + baselineoffset))
        }
        context.closePath()
        
    }
}














