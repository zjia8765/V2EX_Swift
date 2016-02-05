//
//  ScrollTabbar.swift
//  V2EX
//
//  Created by zhangjia on 15/12/4.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

enum ScrollTabbarMode{
    case fixWidth //固定宽度
    case flexibleWidth //自适应宽度
    case scaleToFill //根据tabbar宽度等分
}

class ScrollTabbar: UIView {
    var titleArr:NSArray = []
    var itemViews:NSMutableArray = []
    var itemWidth:CGFloat = 50
    var itemPadding:CGFloat = 10
    var tabbarMode:ScrollTabbarMode = .flexibleWidth
    var nonRed:CGFloat = 0,nonGreen:CGFloat = 0,nonBlue:CGFloat = 0,nonAlpha:CGFloat = 0
    var selRed:CGFloat = 0, selGreen:CGFloat = 0, selBlue:CGFloat = 0, selAlpha:CGFloat = 0
    var titleColor:UIColor = UIColor.blackColor()
    {
        didSet{
            titleColor.getRed(&nonRed, green: &nonGreen, blue: &nonBlue, alpha: &nonAlpha)
        }
    }
    var selectedTitleColor:UIColor = UIColor.redColor()
    {
        didSet{
            selectedTitleColor.getRed(&selRed, green: &selGreen, blue: &selBlue, alpha: &selAlpha)
        }
    }
    var scrollView:UIScrollView = UIScrollView()
    var selectedIndex:NSInteger = 0
    var tabItemDidSelected:((index:NSInteger)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        scrollView.frame = frame
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        titleColor.getRed(&nonRed, green: &nonGreen, blue: &nonBlue, alpha: &nonAlpha)
        selectedTitleColor.getRed(&selRed, green: &selGreen, blue: &selBlue, alpha: &selAlpha)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTabbarWithTitles(titles:NSArray){
        
        self.clearTabbarItem()
        titleArr = titles
        
        for index in 0..<titleArr.count{
            let nodeButton:UIButton;
            if index > itemViews.count-1{
                nodeButton = self.creatTabbarItem()
                itemViews.addObject(nodeButton)
            }else{
                nodeButton = itemViews[index] as! UIButton
            }
            nodeButton.setTitle((titleArr[index] as! String), forState: UIControlState.Normal)
            nodeButton.titleLabel!.adjustsFontSizeToFitWidth = true;
            nodeButton.sizeToFit()
            nodeButton.hidden = false
            scrollView.addSubview(nodeButton)
            
        }
        self.setNeedsLayout()
    }
    
    func creatTabbarItem()->UIButton{
        let tabbarItem:UIButton = UIButton()
        tabbarItem.backgroundColor = UIColor.clearColor()
        tabbarItem.addTarget(self, action: "tabItemDidPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        tabbarItem.setTitleColor(titleColor, forState: UIControlState.Normal)
        tabbarItem.titleLabel?.font = UIFont.systemFontOfSize(15)
        
        return tabbarItem
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        scrollView.frame = CGRectMake(0, 0, self.width(), self.height())
        
        let startPointY:CGFloat = 0.0
        var itemRight:CGFloat = itemPadding
        let itemFixWidth = (self.scrollView.width()-(CGFloat(titleArr.count+1)*itemPadding))/CGFloat(titleArr.count)
        
        for index in 0..<titleArr.count {
            let tabbarItem:UIButton = itemViews[index] as! UIButton
            tabbarItem.tag = index
            if index == selectedIndex{
                tabbarItem.setTitleColor(selectedTitleColor, forState: UIControlState.Normal)
                tabbarItem.userInteractionEnabled = false
            }else{
                tabbarItem.setTitleColor(titleColor, forState: UIControlState.Normal)
                tabbarItem.userInteractionEnabled = true
            }
            
            if tabbarMode == .fixWidth {
                tabbarItem.setWidth(itemWidth)
            }else if tabbarMode == .scaleToFill {
                tabbarItem.setWidth(itemFixWidth)
            }
            tabbarItem.setLeft(itemRight)
            tabbarItem.setTop(startPointY)
            tabbarItem.setHeight(scrollView.height())
            itemRight = tabbarItem.right() + itemPadding
        }
        
        scrollView.contentSize = CGSizeMake(itemRight, self.height())
    }
    
    func clearTabbarItem(){
        for index in 0..<itemViews.count{
            let nodeButton = itemViews[index] as! UIButton
            nodeButton.hidden = true
            nodeButton.setTitle(nil, forState: UIControlState.Normal)
            if let _ = nodeButton.superview{
                nodeButton.removeFromSuperview()
            }
        }
    }
    
    func setSelectedTabbarItem(index:NSInteger,isPress:Bool = false){
        if index == selectedIndex{
            return
        }
        let selectedItem:UIButton = itemViews[selectedIndex] as! UIButton
        selectedItem.setTitleColor(titleColor, forState: UIControlState.Normal)
        selectedItem.userInteractionEnabled = true
        
        selectedIndex = index
        let targetBtn:UIButton = itemViews[selectedIndex] as! UIButton
        targetBtn.setTitleColor(selectedTitleColor, forState: UIControlState.Normal)
        targetBtn.userInteractionEnabled = false

        let leftOffset:CGFloat = scrollView.contentOffset.x
        let rightOffset:CGFloat = scrollView.contentSize.width - leftOffset - scrollView.width()
        if rightOffset >= 0{
            let scrollCenterX:CGFloat = scrollView.centerX()
            let centerOffset:CGFloat = targetBtn.centerX() - leftOffset - scrollCenterX
            if centerOffset > 0{
                if rightOffset > centerOffset {
                    scrollView.setContentOffset(CGPointMake(leftOffset+centerOffset, 0), animated: true)
                }else{
                    scrollView.setContentOffset(CGPointMake(scrollView.contentSize.width-scrollView.width(), 0), animated: true)
                }
            }else{
                if leftOffset > (-centerOffset){
                    scrollView.setContentOffset(CGPointMake(leftOffset+centerOffset, 0), animated: true)
                }else{
                    scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
                }
            }
        }
        if isPress{
            tabItemDidSelected?(index:selectedIndex)
        }
        
    }
    
    func tabItemDidPressed(button:UIButton){
        self.setSelectedTabbarItem(button.tag,isPress:true)
    }
    
    func updateTabbarWithContainerScrollView(cScrollView:UIScrollView){
        if cScrollView.contentOffset.x >= 0 && cScrollView.contentOffset.x <= cScrollView.contentSize.width{
            
            let locationIndex:Float = Float(cScrollView.contentOffset.x / cScrollView.width())
            let ratio:CGFloat = CGFloat(fmodf(locationIndex, 1))
//            let fontRatio:CGFloat = CGFloat(floor(ratio*100)/100)
            let prevIndex:Int = Int(floor(locationIndex))
            let nextIndex:Int = Int(ceil(locationIndex))
            
            if prevIndex == nextIndex{
                return
            }
            var lblPrevItem:UIButton?
            if prevIndex >= 0 {
                lblPrevItem = itemViews[prevIndex] as? UIButton
            }
            
            var lblNextItem:UIButton?
            if nextIndex < itemViews.count{
                lblNextItem = itemViews[nextIndex] as? UIButton
            }
            
            
            let pRed = (nonRed - selRed) * ratio + selRed
            let pGreen = (nonGreen - selGreen) * ratio + selGreen
            let pBlue = (nonBlue - selBlue) * ratio + selBlue
            lblPrevItem?.setTitleColor(UIColor(red: pRed, green: pGreen, blue: pBlue, alpha: 1), forState: UIControlState.Normal)
            
            let nRed = (selRed - nonRed) * ratio + nonRed
            let nGreen = (selGreen - nonGreen) * ratio + nonGreen
            let nBlue = (selBlue - nonBlue) * ratio + nonBlue
            lblNextItem?.setTitleColor(UIColor(red: nRed, green: nGreen, blue: nBlue, alpha: 1), forState: UIControlState.Normal)
            
        }
    }
}
