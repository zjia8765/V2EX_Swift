//
//  CategoriesViewModel.swift
//  V2EX
//
//  Created by 张佳 on 15/12/5.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class CategoriesViewModel {
    var sectionArray:NSArray!
    var sectionTitleArray:NSMutableArray = []
    var sectionDataDic:NSMutableDictionary!
    var sectionViews:NSMutableDictionary!
    
    init()
    {
        sectionArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("Categories", ofType: "plist")!)
        sectionArray.enumerateObjectsUsingBlock { (Object, index, stop) -> Void in
            self.sectionTitleArray.addObject((Object as! NSDictionary)["name"]!)
        }
        sectionDataDic = NSMutableDictionary()
        sectionViews = NSMutableDictionary()
    }
    
    func requestNew(type:NSInteger,callBlack:((dataArray:NSArray?)->())? = nil){

        let tabTitle = (sectionArray[type] as! NSDictionary)["title"] as! String
        NetworkManager.sharedInstance.fetchCategoriesArticleList(tabTitle) {[unowned self]
            (articleList:[ArticleModel]?,error:ErrorType?) -> () in
            print(articleList)
            if articleList != nil  {
                self.sectionDataDic.setObject(articleList!, forKey: String(type))

            }
            callBlack?(dataArray:articleList)
        }
    }
    
}
