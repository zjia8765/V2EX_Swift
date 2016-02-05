//
//  ArticleTableViewCell.swift
//  V2EX
//
//  Created by zhangjia on 15/12/1.
//  Copyright © 2015年 ZJ. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleAvatar: UIImageView!
    @IBOutlet weak var articleTimeLabel: UILabel!
    @IBOutlet weak var articleNodeLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    
    var articleInfo:ArticleModel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateArticleTableViewCell(cellInfo:ArticleModel){
        articleInfo = cellInfo
        
        articleTitleLabel.text = cellInfo.articleTitle
        articleAvatar.kf_setImageWithURL(NSURL(string: cellInfo.articleAvatar!)!, placeholderImage: UIImage(named: "avart_default"))
        articleTimeLabel.text = cellInfo.articleTime
        articleNodeLabel.text = cellInfo.articleNode
        articleAuthorLabel.text = cellInfo.articleAuthor
    }
}
