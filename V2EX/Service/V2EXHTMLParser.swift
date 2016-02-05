//
//  V2EXHTMLParser.swift
//  V2EX
//
//  Created by zhangjia on 15/12/1.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import Foundation
import Ji

class V2EXHTMLParser: NSObject {
    
    class func parseArticleList(ji: Ji) -> [ArticleModel] {
        var models = [ArticleModel]()
        
        guard let nodes = ji.xPath("//div[@class='cell item']") else {
            return models
        }
        
        for node in nodes {
            let inner = node.xPath("table/tr/td")
            let model = ArticleModel()
            for tdNode in inner {
                print (tdNode.description)
                
                if tdNode.description.containsString("class=\"avatar\""){
                    
                    let aLable = tdNode.xPath("a").first!
                    if let authorNode = aLable["href"]{
                        
                        model.articleAuthor = authorNode.componentsSeparatedByString("/").last
                    }
                    
                    let imageNode = aLable.xPath("img").first!
                    if let imageURL = imageNode["src"] {
                        model.articleAvatar = "http:"+imageURL
                    }
                }
                
                if tdNode.description.containsString("<span") {
                    let itemTitle = tdNode.xPath("span[@class='item_title']/a").first!
                    if let replyNode = itemTitle["href"]{
                        let replyNodeArr = replyNode.componentsSeparatedByString("#")
                        if let articleId = replyNodeArr.first{
                            model.articleId = articleId.componentsSeparatedByString("/").last
                        }
                        if let replyStr = replyNodeArr.last{
                            model.articleReplyCount = (replyStr as NSString).substringFromIndex(("reply" as NSString).length)
                        }
                        
                    }
                    model.articleTitle = itemTitle.content!
                    
                    let fromNode = tdNode.xPath("span/a[@class='node']").first!
                    model.articleNode = fromNode.content!
                    
                    let content = tdNode.xPath("span[@class='small fade']").first!.content!
                    let comtentArray = content.componentsSeparatedByString("•")
                    if comtentArray.count > 2 && comtentArray[2].containsString("前") {
                        model.articleTime = comtentArray[2]
                    }
                }
                
            }
            models.append(model)
        }
        return models
    }
}
