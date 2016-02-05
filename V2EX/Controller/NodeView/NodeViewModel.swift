//
//  NodeViewModel.swift
//  V2EX
//
//  Created by zhangjia on 15/12/2.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class NodeViewModel {
    var headerTitleArray:[String] = ["分享与探索", "V2EX", "iOS", "Geek", "游戏", "Apple", "生活", "Internet", "城市", "品牌"]
    var allNodeList:NSArray!
    init()
    {
        allNodeList = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("NodesList", ofType: "plist")!)
        
    }
    
}
