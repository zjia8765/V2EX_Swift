//
//  UIButtonExt.swift
//  V2EX
//
//  Created by zhangjia on 15/12/3.
//  Copyright © 2015年 ZJ. All rights reserved.
//
import UIKit
import Foundation
extension UIButton{
    func sizeWidthToFitsWithTitle()->CGSize{
        
        let titleSize:CGSize = ((self.titleLabel?.text)! as NSString).boundingRectWithSize(CGSize(width: CGFloat(DBL_MAX), height: self.height()),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: (self.titleLabel?.font)!],
            context: nil).size
        
        return titleSize
    }

}