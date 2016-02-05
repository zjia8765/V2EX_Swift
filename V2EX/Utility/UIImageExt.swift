//
//  UIImageExt.swift
//  ZhiHuDaily-Swift
//
//  Created by zhangjia on 15/11/16.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
extension UIImage {
    class func imageWithColor(color: UIColor ,size:CGSize) -> UIImage {
        
        let rect:CGRect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect);
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img
    }
    
    class func imageWithColor(color: UIColor) -> UIImage {
        
        return UIImage.imageWithColor(color, size: CGSizeMake(1, 1))
    }
}
