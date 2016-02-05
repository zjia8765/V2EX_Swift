//
//  LatestViewModel.swift
//  V2EX
//
//  Created by zhangjia on 15/12/1.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class LatestViewModel {
    var dataArray:NSMutableArray = []
    var pageNum = 1
    init()
    {

    }
    
    func requestNew(callback:(()->Void)? = nil){
        pageNum = 1
        NetworkManager.sharedInstance.fetchLatestArticleList("\(pageNum)") {[unowned self]
            (articleList:[ArticleModel]?,error:ErrorType?) -> () in
            print(articleList)
            if articleList != nil  {
               self.dataArray = NSMutableArray(array: articleList!)
                self.pageNum++
            }
            
            callback?()
        }
    }
    
    func requestMore(callback:(()->Void)? = nil){
        NetworkManager.sharedInstance.fetchLatestArticleList("\(pageNum)") { (articleList:[ArticleModel]?,error:ErrorType?) -> () in
            if articleList != nil  {
                self.dataArray.addObjectsFromArray(articleList!)
                self.pageNum++
            }
            
            callback?()
        }
    }
}
