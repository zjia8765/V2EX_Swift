//
//  NodeViewController.swift
//  V2EX
//
//  Created by zhangjia on 15/11/30.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

let NodeTableViewCellIndetifer = "NodeTableViewCellIndetifer"

class NodeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var nodeTableView:UITableView!
    var nodeViewModel:NodeViewModel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        self.title = "节点"
        let item:UITabBarItem = UITabBarItem.init(title: "节点", image: UIImage(named: "tab_node_normal"), selectedImage: UIImage(named: "tab_node_highlight"))
        self.tabBarItem = item;

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nodeViewModel = NodeViewModel()
        // Do any additional setup after loading the view.
        nodeTableView = UITableView(frame: self.view.frame)
        nodeTableView.delegate = self
        nodeTableView.dataSource = self
        nodeTableView.backgroundColor = UIColor.clearColor()
        nodeTableView.showsVerticalScrollIndicator = false
//        let cellNib:UINib = UINib(nibName: "NodeTableViewCell", bundle: nil)
//        self.nodeTableView.registerNib(cellNib, forCellReuseIdentifier: NodeTableViewCellIndetifer)
        nodeTableView.registerClass(NodeTableViewCell.self, forCellReuseIdentifier: NodeTableViewCellIndetifer)
        view.addSubview(nodeTableView)
        
        nodeTableView.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(0)
        }
        
        nodeTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return nodeViewModel.allNodeList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 36
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return nodeViewModel.headerTitleArray[section]
    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let height:CGFloat = tableView.fd_heightForCellWithIdentifier(NodeTableViewCellIndetifer, cacheByIndexPath: indexPath) { [weak self]
            (cell) -> Void in
            let nodeArr:NSArray = self?.nodeViewModel.allNodeList[indexPath.section] as! NSArray
            let nodeCell = cell as! NodeTableViewCell
            nodeCell.updateNodeItems(nodeArr)
            
        }
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let nodeArr:NSArray = nodeViewModel.allNodeList[indexPath.section] as! NSArray
        let nodeCell : NodeTableViewCell  = tableView.dequeueReusableCellWithIdentifier(NodeTableViewCellIndetifer, forIndexPath: indexPath) as! NodeTableViewCell
        nodeCell.selectionStyle = .None

        nodeCell.updateNodeItems(nodeArr) {[weak self]
            (index:NSInteger)->() in
            
            print(nodeArr[index])
        }
        return nodeCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
