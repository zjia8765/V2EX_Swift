//
//  ArticleDetailViewModel.swift
//  V2EX
//
//  Created by zhangjia on 15/12/14.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class ArticleDetailViewModel {
    var articleId:String!
    var articleDetail:ArticleDetailModel?
    var replyArray:NSMutableArray = []
    
    func requestDetail(callback:((success:Bool)->Void)? = nil){
        
        NetworkManager.sharedInstance.fetchArticleDetailWithId(articleId){[weak self]
            (articleModel:ArticleDetailModel?,error:ErrorType?) -> Void in
            
            if let detail = articleModel {
                self?.articleDetail = articleModel
                print(detail)
                
                callback?(success: true)
            }else{
                callback?(success: false)
            }
        }
    }
    
    func requestNewReplies(callback:((success:Bool)->Void)? = nil){
        
        NetworkManager.sharedInstance.fetchArticleRepiesWithId(articleId){[weak self]
            (resultArray:NSArray?,error:ErrorType?) -> Void in
            
            if let replyArray = resultArray {
                print(replyArray)
                self?.replyArray.removeAllObjects()
                
                for replyDic in replyArray{
                    if  (replyDic as? NSDictionary) != nil{
                        
                        let replyItme:ArticleReplyModel = ArticleReplyModel()
                        replyItme.parserModelData(replyDic as? NSDictionary)
                        self?.replyArray.addObject(replyItme)
                    }
                }
                callback?(success: true)
            }else{
                callback?(success: false)
            }
        }
    }
}
