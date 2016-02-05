//
//  Helper.swift
//  V2EX
//
//  Created by zhangjia on 15/12/1.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import Foundation
import UIKit

public func alert(message:String) {
    UIAlertView(title: "提示", message: message, delegate: nil, cancelButtonTitle: "取消").show()
}

public func validString(string:String?) ->String{
    return string != nil ? string! : ""
}