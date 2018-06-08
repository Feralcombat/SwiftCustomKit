//
//  UIColorExtension.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit

extension UIColor{
    
    public static func colorWithHexString(_ stringToConvert : String) -> UIColor {
        var cString = stringToConvert.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("0X") {
            let index = cString.index(cString.startIndex, offsetBy: 2)
            cString = String(cString[index...])
        }
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index...])
        }
        let index = cString.index(cString.startIndex, offsetBy: 2);
        let rString = String(cString[..<index])
        cString = String(cString[index...])
        
        let gString = String(cString[..<index])
        cString = String(cString[index...])
        
        let bString = String(cString[..<index])
        
        var r = UInt32();
        var g = UInt32();
        var b = UInt32();
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
}
