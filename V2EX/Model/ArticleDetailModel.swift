//
//  ArticleDetailModel.swift
//  V2EX
//
//  Created by zhangjia on 15/12/14.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class ArticleDetailModel: NSObject {
    var articleUrl:String?
    var articleId:NSNumber?
    var articleContentRendered:String?
    var articleContent:String?
    var articleReplies:NSNumber?
    var articleCreatTime:NSNumber?
    var articleTitle:String?
    var articleMember:MemberModel!
    var articleNode:NodeModel!
    var attributedString:NSMutableAttributedString?
    
    func parserModelData(json:NSDictionary){
        
        articleUrl = json["url"] as? String
        articleId = json["id"] as? NSNumber
        articleContentRendered = json["content_rendered"] as? String
        articleContent = json["content"] as? String
        articleReplies = json["replies"] as? NSNumber
        articleCreatTime = json["created"] as? NSNumber
        articleTitle = json["title"] as? String
        
        articleMember = MemberModel()
        articleMember?.parserModelData(json["member"] as? NSDictionary)
        
        articleNode = NodeModel()
        articleNode?.parserModelData(json["node"] as? NSDictionary)
        
        var content:NSString = (articleContent! as NSString).stringByReplacingOccurrencesOfString("\r", withString: "\n")
        while content.rangeOfString("\n\n").location != NSNotFound  {
            content = content.stringByReplacingOccurrencesOfString("\n\n", withString: "\n")
        }
        articleContent = content as String
        
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 8.0
        
        let attributedStr:NSMutableAttributedString = NSMutableAttributedString(string: articleContent!)
        attributedStr.addAttributes([NSForegroundColorAttributeName:UIColor.colorWithRGBHex(0x778087),NSFontAttributeName: UIFont.systemFontOfSize(16),NSParagraphStyleAttributeName: style], range: NSMakeRange(0, articleContent!.length))
        attributedString = attributedStr
    }
}

class MemberModel : NSObject {
    var memberId:NSNumber?
    var username:String?
    var tagline:String?
    var avatarMini:String?
    var avatarNormal:String?
    var avatarLarge:String?
    
    func parserModelData(json:NSDictionary?){
        if let jsonDic = json {
            memberId = jsonDic["id"] as? NSNumber
            username = jsonDic["username"] as? String
            tagline = jsonDic["tagline"] as? String
            avatarMini = jsonDic["avatar_mini"] as? String
            avatarNormal = jsonDic["avatar_normal"] as? String
            avatarLarge = jsonDic["avatar_large"] as? String

        }
    }
}


class NodeModel : NSObject{
    var nodeId:NSNumber?
    var nodeName:String?
    var nodeTitle:String?
    var nodeUrl:String?
    var nodeTopics:NSNumber?
    var avatarMini:String?
    var avatarNormal:String?
    var avatarLarge:String?
    
    func parserModelData(json:NSDictionary?){
        if let jsonDic = json {
            nodeId = jsonDic["id"] as? NSNumber
            nodeName = jsonDic["name"] as? String
            nodeTitle = jsonDic["title"] as? String
            nodeUrl = jsonDic["url"] as? String
            nodeTopics = jsonDic["topics"] as? NSNumber
            avatarMini = jsonDic["avatar_mini"] as? String
            avatarNormal = jsonDic["avatar_normal"] as? String
            avatarLarge = jsonDic["avatar_large"] as? String
            
        }
    }
}