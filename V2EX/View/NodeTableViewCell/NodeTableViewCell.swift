//
//  NodeTableViewCell.swift
//  V2EX
//
//  Created by zhangjia on 15/12/2.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import SnapKit

class NodeTableViewCell: UITableViewCell {
    
    
    var nodeInfoArr:NSArray!
    var nodeView:NodeItemView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nodeView = NodeItemView(frame: self.frame)
        nodeView.backgroundColor = UIColor.clearColor()
    
        contentView.addSubview(nodeView)
        
        nodeView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse(){
        nodeView.clearNodeItem()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    
    func updateNodeItems(nodeItems:NSArray,callBack:((index:NSInteger)->())? = nil){
        
        nodeView.setNodeItems(nodeItems)
        nodeView.nodeItemClickCallBack = callBack
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}


class NodeItemView:UIView {
    var nodeViews:NSMutableArray = []
    var itemOldHeight:CGFloat = 0
    var nodeInfoArr:NSArray = []
    var nodeItemClickCallBack:((index:NSInteger)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearNodeItem(){
        for index in 0..<nodeViews.count{
            let nodeButton = nodeViews[index] as! UIButton
            nodeButton.hidden = true
            nodeButton.setTitle(nil, forState: UIControlState.Normal)
            if let _ = nodeButton.superview{
                nodeButton.removeFromSuperview()
            }
        }
    }
    
    func setNodeItems(nodeItems:NSArray){
        
        nodeInfoArr = nodeItems
        
        for index in 0..<nodeInfoArr.count{
            let nodeButton:UIButton;
            if index > nodeViews.count-1{
                nodeButton = self.creatNodeButton()
                nodeViews.addObject(nodeButton)
            }else{
                nodeButton = nodeViews[index] as! UIButton
            }
            nodeButton.setTitle((nodeInfoArr[index]["name"] as! String), forState: UIControlState.Normal)
            
            nodeButton.titleLabel!.adjustsFontSizeToFitWidth = true;
            nodeButton.sizeToFit()
            nodeButton.setHeight(30)
            nodeButton.hidden = false
            addSubview(nodeButton)
            
        }
        self.setNeedsLayout()
    }
    
    func creatNodeButton()->UIButton{
        let nodeButton:UIButton = UIButton()
        nodeButton.backgroundColor = UIColor.clearColor()
        nodeButton.addTarget(self, action: "nodeItemDidPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        nodeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        nodeButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        return nodeButton
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        var startPointX:CGFloat = 0.0
        var startPointY:CGFloat = 0.0
        var itemRight:CGFloat = 0.0
        var itemButtom:CGFloat = 0.0
        for index in 0..<nodeInfoArr.count {
            let nodeItem:UIButton = nodeViews[index] as! UIButton

            nodeItem.tag = index
            if nodeItem.width() > kScreenSize.width - 20 - itemRight {
                startPointX = 0.0
                startPointY = startPointY + nodeItem.height() + 10
            }else{
                startPointX = itemRight
            }
            
            nodeItem.setLeft(startPointX)
            nodeItem.setTop(startPointY)
            itemButtom = nodeItem.bottom()
            itemRight = nodeItem.right() + 10
        }
        
        if itemOldHeight != itemButtom{
            self.setHeight(itemButtom)
            self.invalidateIntrinsicContentSize()
            itemOldHeight = itemButtom
        }
        
    }
    
    override func intrinsicContentSize() -> CGSize{
        
        var size:CGSize = super.intrinsicContentSize()
        if nodeInfoArr.count != 0{
            let maxHeight:CGFloat = (nodeViews[nodeInfoArr.count-1] as! UIView).bottom()
            size = CGSizeMake(self.width(), maxHeight);
        }
        
        return size
    }
    
    func nodeItemDidPressed(button:UIButton){
        nodeItemClickCallBack?(index:button.tag)
    }
}