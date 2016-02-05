//
//  ArticleTableView.swift
//  V2EX
//
//  Created by zhangjia on 15/12/1.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import MJRefresh
import UITableView_FDTemplateLayoutCell

let ArticleTableViewCellIndetifer = "ArticleTableViewCellIndetifer"

class ArticleTableView: UIView,UITableViewDelegate,UITableViewDataSource{
    var listTableView:UITableView!
    var articleDataArray:NSArray = []
    var loadNewCallBlock:(()->())?
    var loadMoreCallBlock:(()->())?
    var tableViewdidSelectRowBlock:((indexPath:NSIndexPath)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        listTableView = UITableView(frame: frame)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.backgroundColor = UIColor.clearColor()
        listTableView.showsVerticalScrollIndicator = false
        let cellNib:UINib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        self.listTableView.registerNib(cellNib, forCellReuseIdentifier: ArticleTableViewCellIndetifer)
//        listTableView.registerClass(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCellIndetifer)
        addSubview(self.listTableView)
        
        listTableView.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(0)
        }
        
        listTableView.mj_header = MJRefreshNormalHeader()
        listTableView.mj_header.refreshingBlock = {[weak self]
            ()->() in
            self?.loadNewCallBlock?()
        }
        
        listTableView.mj_footer = MJRefreshAutoNormalFooter()
        listTableView.mj_footer.refreshingBlock = {[weak self]
            ()->() in
            self?.loadMoreCallBlock?()
        }
        
    }
    
    func triggerLoadNew(){
        self.listTableView.mj_header.beginRefreshing()
    }
    
    func endRefreshing (){
        listTableView.mj_header.endRefreshing()
        listTableView.mj_footer.endRefreshing()
    }
    
    func updateArtcileData(listaData:NSArray){
        
        articleDataArray = listaData
        
        listTableView .reloadData()
        
    }
    
    func loadMoreEnable(enable:Bool){
        if enable{
            listTableView.mj_footer.resetNoMoreData()
        }else{
            listTableView.mj_footer.endRefreshingWithNoMoreData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleDataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let height:CGFloat = tableView.fd_heightForCellWithIdentifier(ArticleTableViewCellIndetifer, cacheByIndexPath: indexPath) { [weak self]
            (cell) -> Void in
            let articleInfo:ArticleModel = self?.articleDataArray[indexPath.row] as! ArticleModel
            let articleCell = cell as! ArticleTableViewCell
            articleCell.updateArticleTableViewCell(articleInfo)
            
        }
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let articleInfo:ArticleModel = articleDataArray[indexPath.row] as! ArticleModel
        
        var cell : ArticleTableViewCell
        cell = tableView.dequeueReusableCellWithIdentifier(ArticleTableViewCellIndetifer, forIndexPath: indexPath) as! ArticleTableViewCell
        cell.selectionStyle = .None
        
        cell.updateArticleTableViewCell(articleInfo)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableViewdidSelectRowBlock?(indexPath: indexPath)
    }
}
