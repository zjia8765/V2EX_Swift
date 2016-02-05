//
//  UIViewExt.swift
//  ZhiHuDaily-Swift
//
//  Created by zhangjia on 15/11/16.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import Foundation
extension UIView{
    func left()->CGFloat{
        return self.frame.origin.x
    }
    
    func right()->CGFloat{
        return self.frame.origin.x + self.frame.size.width
    }
    
    func top()->CGFloat
    {
        return self.frame.origin.y
    }
    func bottom()->CGFloat
    {
        return self.frame.origin.y + self.frame.size.height
    }
    func width()->CGFloat
    {
        return self.frame.size.width
    }
    func height()-> CGFloat
    {
        return self.frame.size.height
    }
    func centerX()-> CGFloat
    {
        return self.center.x
    }
    func centerY()-> CGFloat
    {
        return self.center.y
    }
    func setLeft(x: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setRight(right: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setTop(y: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setBottom(bottom: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth(width: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(height: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    func setCenterX(centerX: CGFloat)
    {
        self.center = CGPointMake(centerX, self.center.y)
    }
    func setCenterY(centerY: CGFloat)
    {
        self.center = CGPointMake(self.center.x, centerY)
    }
}