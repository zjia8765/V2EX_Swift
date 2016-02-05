//
//  CategoriesViewController.swift
//  V2EX
//
//  Created by zhangjia on 15/11/30.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseViewController {

    var tabbarView:ScrollTabbar!
    var scrollContainerView:ScrollContainerView!
    var categoriesViewModel:CategoriesViewModel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        self.title = "分类"
        let item:UITabBarItem = UITabBarItem.init(title: "分类", image: UIImage(named: "tab_category_normal"), selectedImage: UIImage(named: "tab_category_highlight"))
        self.tabBarItem = item;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesViewModel = CategoriesViewModel()
        tabbarView = ScrollTabbar(frame: CGRectMake(0, 0,self.view.width(),50))
//        tabbarView.titleColor = UIColor.grayColor()
//        tabbarView.selectedTitleColor = UIColor.blueColor()
        tabbarView.updateTabbarWithTitles(categoriesViewModel.sectionTitleArray)
        view.addSubview(tabbarView)
        tabbarView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(0)
            make.height.equalTo(50)
        }
        tabbarView.tabItemDidSelected = {[weak self]
            (index:NSInteger)->() in
            self?.scrollContainerView.setContentPageIndex(index, animated: false)
            self?.switchToContainerIndex(index)
            
        }
        
        
        scrollContainerView = ScrollContainerView(frame: CGRectMake(0, tabbarView.bottom(),self.view.width(),self.view.height()-tabbarView.bottom()))
        scrollContainerView.setTotalContentViewCount(categoriesViewModel.sectionTitleArray.count)
        view.addSubview(scrollContainerView)
        scrollContainerView.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(tabbarView.snp_bottom)
        }
        scrollContainerView.didEndDeceleratingWithIndex = {[weak self]
            (contentView:ScrollContainerView,pageIndex:NSInteger) -> () in
            self?.switchToContainerIndex(pageIndex)
            self?.tabbarView.setSelectedTabbarItem(pageIndex)
        }
        
        scrollContainerView.scrollContainerViewDidScroll = {[weak self]
            (scrollView:UIScrollView)->() in
            self?.tabbarView.updateTabbarWithContainerScrollView(scrollView)
        }
        
        let delayInSeconds = 0.2
        let popTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            self.switchToContainerIndex(0)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func switchToContainerIndex(index:NSInteger){
        if let _ = categoriesViewModel.sectionViews[String(index)]  {
            
        }else{
            let articleTableView:ArticleTableView = ArticleTableView(frame: CGRectMake(0,0,scrollContainerView.width(),scrollContainerView.height()))
            
            articleTableView.loadNewCallBlock = {[weak self]
                ()->() in
                self?.categoriesViewModel.requestNew(index)  {
                    (dataArray:NSArray?)->() in
                    
                    if let articleArray = dataArray{
                         articleTableView.updateArtcileData(articleArray)
                    }
                    articleTableView.endRefreshing()
                    articleTableView.loadMoreEnable(false)
                }
            }
            
            articleTableView.tableViewdidSelectRowBlock = {[weak self]
                (indexPath:NSIndexPath) -> Void in
                let articleArray:NSArray = self?.categoriesViewModel.sectionDataDic[String(index)] as! NSArray
                let articleInfo:ArticleModel = articleArray[indexPath.row] as! ArticleModel
                self?.performSegueWithIdentifier("showArticleDetail", sender: articleInfo)
            }
            
            scrollContainerView.addContentSubview(articleTableView, atIndex: index)
            categoriesViewModel.sectionViews.setObject(articleTableView, forKey: String(index))
            articleTableView.triggerLoadNew()
            
        }
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
    

}
