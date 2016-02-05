//
//  ScrollContainerView.swift
//  V2EX
//
//  Created by 张佳 on 15/12/5.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit

class ScrollContainerView: UIView {

    var scrollView:UIScrollView!
    var totalPage = 0
    var didEndDeceleratingWithIndex:((contentView:ScrollContainerView,pageIndex:NSInteger)->())?
    var scrollContainerViewDidScroll:((scrollView:UIScrollView)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.directionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) -> Void in
            make.top.left.bottom.right.equalTo(0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = CGSizeMake(CGFloat(totalPage) * scrollView.width(), scrollView.height())
        
    }
    func setTotalContentViewCount(count:NSInteger){
        totalPage = count
        scrollView.contentSize = CGSizeMake(CGFloat(totalPage) * scrollView.width(), scrollView.height())
    }
    
    func addContentSubview(subview:UIView,atIndex:NSInteger){
        scrollView.addSubview(subview)
        subview.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(CGFloat(atIndex) * scrollView.width())
            make.width.equalTo(scrollView.width())
            make.height.equalTo(scrollView.height())
        }
        
    }
    
    func setContentPageIndex(index:NSInteger,animated:Bool){
        scrollView.setContentOffset(CGPointMake(CGFloat(index)*scrollView.width(), 0), animated: animated)
    }
}

extension ScrollContainerView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        let index:NSInteger = NSInteger(scrollView.contentOffset.x / scrollView.width())
        didEndDeceleratingWithIndex?(contentView:self, pageIndex: index)     }
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        scrollContainerViewDidScroll?(scrollView: scrollView)
    }
}
