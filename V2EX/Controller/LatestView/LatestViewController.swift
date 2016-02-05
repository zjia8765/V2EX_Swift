//
//  LatestViewController.swift
//  V2EX
//
//  Created by zhangjia on 15/11/30.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class LatestViewController: BaseViewController {

    var articleTableView:ArticleTableView!
    var latestViewModel:LatestViewModel!
    var playLink:CADisplayLink!
    var count:NSInteger = 0
    var lastTime:NSTimeInterval = 0
    override func awakeFromNib(){
        super.awakeFromNib()
        self.title = "最新"
        let item:UITabBarItem = UITabBarItem.init(title: "最新", image: UIImage(named: "tab_lates_normal"), selectedImage: UIImage(named: "tab_lates_highlight"))
        self.tabBarItem = item;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        latestViewModel = LatestViewModel()
        articleTableView = ArticleTableView(frame: self.view.frame)
        view.addSubview(articleTableView)
        
        articleTableView.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(0)
        }
        
        articleTableView.loadNewCallBlock = {[weak self]
            ()->() in
            self?.latestViewModel.requestNew{
                ()->() in
                self?.updateTableDidLoadFinish()
            }
        }
        
        articleTableView.loadMoreCallBlock = {[weak self]
            ()->() in
            self?.latestViewModel.requestMore(){
                ()->() in
                self?.updateTableDidLoadFinish()
            }
        }
        
        articleTableView.tableViewdidSelectRowBlock = {[weak self]
            (indexPath:NSIndexPath) -> Void in
            let articleInfo:ArticleModel = self?.latestViewModel.dataArray[indexPath.row] as! ArticleModel
            self?.performSegueWithIdentifier("showArticleDetail", sender: articleInfo)
        }
        articleTableView.triggerLoadNew()
        
        //刷新帧数
        playLink = CADisplayLink(target: self, selector: "displyTick")
        playLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTableDidLoadFinish()
    {
        articleTableView.endRefreshing()
        articleTableView.updateArtcileData(latestViewModel.dataArray)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showArticleDetail"{
            let detailViewController = segue.destinationViewController as! ArticleDetailViewController
            detailViewController.articleModel = sender as? ArticleModel
            
        }
    }
    
    func displyTick(){
        if lastTime == 0 {
            lastTime = playLink.timestamp
            return
        }
        count++
        let delta:NSTimeInterval = playLink.timestamp - lastTime
        if delta < 1 {
            return
        }
        
        lastTime = playLink.timestamp
        let fps:CGFloat = CGFloat(count) / CGFloat(delta)
        count = 0
        print("fps=\(round(fps))")
    }
}
