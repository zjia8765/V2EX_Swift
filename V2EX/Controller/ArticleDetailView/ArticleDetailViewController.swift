//
//  ArticleDetailViewController.swift
//  V2EX
//
//  Created by zhangjia on 15/12/8.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
import UITableView_FDTemplateLayoutCell

let ArticleDetailTopViewCellIndetifer = "ArticleDetailTopViewCellIndetifer"
let ArticleDetailContentCellIndetifer = "ArticleDetailContentCellIndetifer"
let ArticleReplyViewCellIndetifer = "ArticleReplyViewCellIndetifer"

class ArticleDetailViewController: BaseViewController {

    var articleModel:ArticleModel?
    var viewModel:ArticleDetailViewModel!
    var detailTableView:UITableView!
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ArticleDetailViewModel()
        viewModel.articleId = articleModel?.articleId
        
        
        detailTableView = UITableView(frame: view.frame)
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = UIColor.clearColor()
        detailTableView.showsVerticalScrollIndicator = false
        detailTableView.registerClass(ArticleDetailTopViewCell.self, forCellReuseIdentifier: ArticleDetailTopViewCellIndetifer)
        detailTableView.registerClass(ArticleDetailContentCell.self, forCellReuseIdentifier: ArticleDetailContentCellIndetifer)
        detailTableView.registerClass(ArticleReplyViewCell.self, forCellReuseIdentifier: ArticleReplyViewCellIndetifer)
        detailTableView.separatorStyle = .None
        view.addSubview(detailTableView)
        
        detailTableView.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(0)
        }
        
        detailTableView.mj_header = MJRefreshNormalHeader()
        detailTableView.mj_header.refreshingBlock = {[weak self]
            ()->() in
            self?.viewModel.requestDetail(){[weak self]
                (success:Bool)->Void in
                self?.detailTableView.reloadData()
                self?.detailTableView.mj_header.endRefreshing()
                
                self?.viewModel.requestNewReplies(){[weak self]
                    (success:Bool)->Void in
                    self?.detailTableView.reloadData()
//                    self?.detailTableView.mj_header.endRefreshing()
                }
            }
        }
        
        detailTableView.mj_footer = MJRefreshAutoNormalFooter()
        detailTableView.mj_footer.refreshingBlock = {[weak self]
            ()->() in
            self?.viewModel.requestNewReplies(){[weak self]
                (success:Bool)->Void in
                self?.detailTableView.reloadData()
            }
        }
        
        
        detailTableView.mj_header.beginRefreshing()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ArticleDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? self.viewModel.replyArray.count : 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            let height:CGFloat = tableView.fd_heightForCellWithIdentifier(ArticleDetailTopViewCellIndetifer, cacheByIndexPath: indexPath) { [weak self]
                (cell) -> Void in
                let articleCell = cell as! ArticleDetailTopViewCell
                articleCell.articleDetail = self?.viewModel.articleDetail
                
            }
            return height
        }else if indexPath.section == 1{
            let height:CGFloat = tableView.fd_heightForCellWithIdentifier(ArticleDetailContentCellIndetifer, cacheByIndexPath: indexPath) { [weak self]
                (cell) -> Void in
                let articleCell = cell as! ArticleDetailContentCell
                articleCell.articleDetail = self?.viewModel.articleDetail
                
            }
            return height
        }else {
            let height:CGFloat = tableView.fd_heightForCellWithIdentifier(ArticleReplyViewCellIndetifer, cacheByIndexPath: indexPath) { [weak self]
                (cell) -> Void in
                let articleReplyCell = cell as! ArticleReplyViewCell
                articleReplyCell.replyItem = self?.viewModel.replyArray[indexPath.row] as! ArticleReplyModel
                
            }
            return height
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell:ArticleDetailTopViewCell = tableView.dequeueReusableCellWithIdentifier(ArticleDetailTopViewCellIndetifer, forIndexPath: indexPath) as! ArticleDetailTopViewCell
            cell.selectionStyle = .None
            cell.articleDetail = self.viewModel.articleDetail
            return cell
        }else if indexPath.section == 1{
            let cell:ArticleDetailContentCell = tableView.dequeueReusableCellWithIdentifier(ArticleDetailContentCellIndetifer, forIndexPath: indexPath) as! ArticleDetailContentCell
            cell.selectionStyle = .None
            cell.articleDetail = self.viewModel.articleDetail
            return cell
        }else{
            let cell:ArticleReplyViewCell = tableView.dequeueReusableCellWithIdentifier(ArticleReplyViewCellIndetifer, forIndexPath: indexPath) as! ArticleReplyViewCell
            cell.selectionStyle = .None
            cell.replyItem = self.viewModel.replyArray[indexPath.row] as! ArticleReplyModel
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}
