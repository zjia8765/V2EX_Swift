//
//  ArticleReplyViewCell.swift
//  V2EX
//
//  Created by zhangjia on 15/12/18.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ArticleReplyViewCell: UITableViewCell {
    var authorImageView:UIImageView!
    var authorLabel:UILabel!
    var creatTimeLabel:UILabel!
    var contentLabel:UILabel!
    var separateLine:UIView!
    
    var replyItem:ArticleReplyModel!{
        willSet {
            self.replyItem = newValue
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
        
        contentLabel = UILabel()
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.font = UIFont.systemFontOfSize(15)
        contentLabel.textColor = UIColor.colorWithRGBHex(0x383838)
        contentLabel.numberOfLines = 0
        contentView .addSubview(contentLabel)
        
//        separateLine = UIView()
//        separateLine.backgroundColor = UIColor.lightGrayColor()
//        contentView.addSubview(separateLine)
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
        
        if let replyData = replyItem{
            contentLabel.preferredMaxLayoutWidth = self.width()
            if let avatarUrl = replyData.member.avatarNormal{
                authorImageView.kf_setImageWithURL(NSURL(string: "http:"+(avatarUrl as NSString).substringFromIndex(1))!, placeholderImage: UIImage(named: "avart_default"))
            }
            authorLabel.text = replyData.member.username
            creatTimeLabel.text = NSDate.formattDay((replyData.creatTime?.doubleValue)!)
            contentLabel.text = replyData.content
        }
        
    }
    func setCellConstraints() {
        let offset = 15
        authorImageView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(offset)
            make.width.height.equalTo(30)
            
        }
        
        authorLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(authorImageView.snp_right).offset(offset)
            make.top.equalTo(offset)
            make.right.lessThanOrEqualTo(authorImageView.snp_left).offset(-offset).priorityLow()
        }
        
        creatTimeLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-offset)
            make.centerY.equalTo(authorLabel.snp_centerY)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(authorLabel.snp_left)
            make.top.equalTo(authorLabel.snp_bottom).offset(10)
            make.right.equalTo(-offset)
            make.bottom.equalTo(-offset)
        }
        
//        separateLine.snp_makeConstraints { (make) -> Void in
//            make.left.right.equalTo(0)
//            make.height.equalTo(0.5)
//            make.top.equalTo(contentLabel.snp_bottom).offset(offset)
//            make.bottom.equalTo(0)
//        }
        authorLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        creatTimeLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
    }
}
