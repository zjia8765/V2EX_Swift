//
//  ArticleReplyModel.swift
//  V2EX
//
//  Created by zhangjia on 15/12/18.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class ArticleReplyModel: NSObject {
    var articleId:NSNumber!
    var thanksCount:NSNumber!
    var content:String!
    var contentRendered:String!
    var member:MemberModel!
    var creatTime:NSNumber!
    var lastModified:NSNumber!
    
    func parserModelData(json:NSDictionary?){
        if let jsonDic = json {
            articleId = jsonDic["id"] as? NSNumber
            thanksCount = jsonDic["thanks"] as? NSNumber
            content = jsonDic["content"] as? String
            contentRendered = jsonDic["content_rendered"] as? String
            
            member = MemberModel()
            member.parserModelData(jsonDic["member"] as? NSDictionary)
            
            creatTime = jsonDic["created"] as? NSNumber
            lastModified = jsonDic["last_modified"] as? NSNumber
            
        }
    }
}
