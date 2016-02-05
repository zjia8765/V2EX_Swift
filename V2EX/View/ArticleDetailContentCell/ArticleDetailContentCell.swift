//
//  ArticleDetailContentCell.swift
//  V2EX
//
//  Created by zhangjia on 15/12/17.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import TTTAttributedLabel

class ArticleDetailContentCell: UITableViewCell {
    
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
        
        contentView.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(15)
            make.bottom.right.equalTo(-15)
        }
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
        
        contentLabel.preferredMaxLayoutWidth = self.width()

        contentLabel.attributedText = articleDetail?.attributedString
    }
    private lazy var contentLabel : TTTAttributedLabel = {
        
        let ttContentLabel = TTTAttributedLabel(frame: CGRectZero)
        ttContentLabel.backgroundColor = UIColor.clearColor()
        ttContentLabel.textColor = UIColor.colorWithRGBHex(0x383838)
        ttContentLabel.font = UIFont.systemFontOfSize(16)
        ttContentLabel.numberOfLines = 0
        ttContentLabel.lineBreakMode = .ByWordWrapping
        
        let style:NSMutableParagraphStyle = NSMutableParagraphStyle()
        style.lineSpacing = 8.0
        ttContentLabel.linkAttributes = [
            NSForegroundColorAttributeName:UIColor.colorWithRGBHex(0x778087),
            NSFontAttributeName: UIFont.systemFontOfSize(16),
            NSParagraphStyleAttributeName: style
        ]

        ttContentLabel.activeLinkAttributes = [
            NSForegroundColorAttributeName: UIColor.grayColor().colorWithAlphaComponent(0.80),
            NSUnderlineStyleAttributeName: NSNumber(bool:true),
        ]
        return ttContentLabel
    }()
}
