//
//  NetworkManager.swift
//  V2EX
//
//  Created by zhangjia on 15/12/1.
//  Copyright © 2015年 ZJ. All rights reserved.
//
import Alamofire
import Ji
import SwiftyJSON

class NetworkManager{
    
    static let sharedInstance = NetworkManager()
    private init() {}
    
    func netWorkRequest( method: Alamofire.Method , path: String, cheat:Bool = true, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL) -> Request {
            
            var headers:[String: String]?
            if cheat {
                headers = [String: String]()
                headers!["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36"
            }
            
            
            return Alamofire.request(method, http_base_url+path, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    func fetchLatestArticleList(page:String,callback:(articleList:[ArticleModel]?,error:ErrorType?)->Void)->Void{
        var paraDict = Dictionary<String, AnyObject>()
        paraDict["p"] = page
        
        netWorkRequest(.GET, path:"recent",cheat:false,parameters: paraDict).responseJi { (ji, error) -> Void in
            print(ji)
            if error != nil{
                callback(articleList:nil,error:error)
            }else{
                let articleArray = V2EXHTMLParser.parseArticleList(ji!)
                callback(articleList:articleArray,error:nil)
            }
            
            
        }
    }
    
    func fetchCategoriesArticleList(tabTitle:String,callback:(articleList:[ArticleModel]?,error:ErrorType?)->Void)->Void{
        var paraDict = Dictionary<String, AnyObject>()
        paraDict["tab"] = tabTitle
        
        netWorkRequest(.GET, path:"",cheat:false,parameters: paraDict).responseJi { (ji, error) -> Void in
            print(ji)
            if error != nil{
                callback(articleList:nil,error:error)
            }else{
                let articleArray = V2EXHTMLParser.parseArticleList(ji!)
                callback(articleList:articleArray,error:nil)
            }
            
            
        }
    }
//    http://www.v2ex.com/api/topics/show.json?id=243378
//    http://www.v2ex.com/api/replies/show.json?topic_id=243342
    func fetchArticleDetailWithId(nId:String,callback:(articleDetail:ArticleDetailModel?,error:ErrorType?)->Void)->Void{
        var paraDict = Dictionary<String, AnyObject>()
        paraDict["id"] = nId
        
        netWorkRequest(.GET, path: "api/topics/show.json?", cheat: false, parameters: paraDict).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if let detailDic = json[0].dictionaryObject  {
                        let data:ArticleDetailModel = ArticleDetailModel()
                        data.parserModelData(detailDic)
                        
                        callback(articleDetail: data, error: nil)
                    }else{
                        callback(articleDetail: nil, error: nil)
                    }
                }
            case .Failure(let error):
                print(error)
                callback(articleDetail: nil, error: error)
            }
            
        }
    }
    
    func fetchArticleRepiesWithId(nId:String, callback:(resultArray:NSArray?,error:ErrorType?)->Void)->Void{
        var paraDict = Dictionary<String, AnyObject>()
        paraDict["topic_id"] = nId
        
        netWorkRequest(.GET, path: "api/replies/show.json?", cheat: false, parameters: paraDict).responseJSON { response in
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if let resultArr = json.arrayObject {
                        
                        callback(resultArray: resultArr, error: nil)
                    }else{
                        callback(resultArray: nil, error: nil)
                    }
                }
            case .Failure(let error):
                print(error)
                callback(resultArray: nil, error: error)
            }
            
        }
    }
}

extension Request {
    
    func responseJi(completionJi:(ji:Ji?,error:ErrorType?) -> Void) -> Self {
        
        return response(completionHandler: { (request, response, data, error) -> Void in
            guard error == nil && data != nil else {
                alert("您的网络有问题，请确认网络是否异常")
                completionJi(ji: nil, error: error)
                return
            }
            
            
            let jiDoc = Ji(htmlData: data!)!
            completionJi(ji: jiDoc, error: error)
        })
    }
}
