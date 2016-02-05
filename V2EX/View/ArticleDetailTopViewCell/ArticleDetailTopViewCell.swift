//
//  ArticleDetailTopViewCell.swift
//  V2EX
//
//  Created by zhangjia on 15/12/17.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ArticleDetailTopViewCell: UITableViewCell {
    
    var nodeBackgroundView:UIView!
    var nodeTitleLabel:UILabel!
    var nodeRightArrow:UILabel!
    
    var articleTitleLabel:UILabel!
    var authorImageView:UIImageView!
    var authorLabel:UILabel!
    var creatTimeLabel:UILabel!
    var repliesCount:UILabel!
    
    var articleDetail:ArticleDetailModel?{
        willSet {
            self.articleDetail = newValue
        }
    
        didSet{
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nodeBackgroundView = UIView()
        nodeBackgroundView.backgroundColor = UIColor.colorWithRGBHex(0xfafafa)
        contentView.addSubview(nodeBackgroundView)
        
        nodeTitleLabel = UILabel()
        nodeTitleLabel.backgroundColor = UIColor.clearColor()
        nodeTitleLabel.font = UIFont.systemFontOfSize(15)
        nodeTitleLabel.textColor = UIColor.colorWithRGBHex(0x989898)
        nodeBackgroundView .addSubview(nodeTitleLabel)
        
        nodeRightArrow = UILabel()
        nodeRightArrow.backgroundColor = UIColor.clearColor()
        nodeRightArrow.textColor = UIColor.colorWithRGBHex(0x989898)
        nodeRightArrow.text = ">"
        nodeRightArrow.font = UIFont.systemFontOfSize(16)
        nodeBackgroundView.addSubview(nodeRightArrow)
        
        articleTitleLabel = UILabel()
        articleTitleLabel.backgroundColor = UIColor.clearColor()
        articleTitleLabel.numberOfLines = 0
        articleTitleLabel.textColor = UIColor.blackColor()
        articleTitleLabel.font = UIFont.systemFontOfSize(17)
        contentView.addSubview(articleTitleLabel)
        
        authorImageView = UIImageView()
        contentView.addSubview(authorImageView)
        
        authorLabel = UILabel()
        authorLabel.backgroundColor = UIColor.clearColor()
        authorLabel.font = UIFont.systemFontOfSize(15)
        authorLabel.textColor = UIColor.colorWithRGBHex(0x778086)
        contentView.addSubview(authorLabel)
        
        creatTimeLabel = UILabel()
        creatTimeLabel.backgroundColor = UIColor.clearColor()
        creatTimeLabel.font = UIFont.systemFontOfSize(15)
        creatTimeLabel.textColor = UIColor.colorWithRGBHex(0x989898)
        contentView .addSubview(creatTimeLabel)
        
        repliesCount = UILabel()
        repliesCount.backgroundColor = UIColor.clearColor()
        repliesCount.font = UIFont.systemFontOfSize(15)
        repliesCount.textColor = UIColor.colorWithRGBHex(0x989898)
        contentView .addSubview(repliesCount)
        
        self.setCellConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let detailData = articleDetail{
            articleTitleLabel.preferredMaxLayoutWidth = self.width()
            nodeTitleLabel.text = detailData.articleNode.nodeTitle
            articleTitleLabel.text = detailData.articleTitle
            if let avatarUrl = detailData.articleMember.avatarNormal{
                authorImageView.kf_setImageWithURL(NSURL(string: "http:"+(avatarUrl as NSString).substringFromIndex(1))!, placeholderImage: UIImage(named: "avart_default"))
            }
            authorLabel.text = detailData.articleMember.username
            repliesCount.text = (detailData.articleReplies?.stringValue)!+"回复"
            creatTimeLabel.text = NSDate.formattDay((detailData.articleCreatTime?.doubleValue)!)
        }
        
        
    }
    func setCellConstraints() {
        let offset = 15
        
        nodeBackgroundView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(0)
            make.height.equalTo(40)
        }
        nodeRightArrow.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-offset)
            make.centerY.equalTo(nodeBackgroundView.snp_centerY)
        }
        
        nodeTitleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(offset)
            make.centerY.equalTo(nodeBackgroundView.snp_centerY)
            make.right.lessThanOrEqualTo(nodeRightArrow.snp_left).offset(-10)
        }
        
        articleTitleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(offset)
            make.right.equalTo(-offset)
            make.top.equalTo(nodeBackgroundView.snp_bottom).offset(offset)
        }
        
        authorImageView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(offset)
            make.top.equalTo(articleTitleLabel.snp_bottom).offset(offset)
            make.width.height.equalTo(30)
            make.bottom.equalTo(-offset)
        }
        
        authorLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(authorImageView.snp_right).offset(10)
            make.centerY.equalTo(authorImageView.snp_centerY)
            make.right.lessThanOrEqualTo(creatTimeLabel.snp_left).offset(-10).priority(250)
        }
        
        repliesCount.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-offset)
            make.centerY.equalTo(authorImageView.snp_centerY)
        }
        
        creatTimeLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(repliesCount.snp_left).offset(-10)
            make.centerY.equalTo(authorImageView.snp_centerY)
            
        }
        authorLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        repliesCount.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        creatTimeLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
    }
    
}
