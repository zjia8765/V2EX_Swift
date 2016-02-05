//
//  UIColorExt.swift
//  ZhiHuDaily-Swift
//
//  Created by zhangjia on 15/11/16.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorWithRGBHex(rgbHex: NSInteger ,alpha:CGFloat) -> UIColor {
        
        return UIColor(red: ((CGFloat)((rgbHex & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbHex & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(rgbHex & 0xFF))/255.0, alpha: alpha)
    }
    
    class func colorWithRGBHex(rgbHex: NSInteger) -> UIColor {
        
        return UIColor.colorWithRGBHex(rgbHex, alpha: 1.0)
    }
}