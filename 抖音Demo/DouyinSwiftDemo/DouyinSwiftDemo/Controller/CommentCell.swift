//
//  CommentCell.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/21.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    // 活的评论数据后，更新UI
    var comment : Comment! {
        didSet{
//            setupUI()
        }
    }
    
    @IBOutlet weak var avatarBtn: UIButton! // 头像
    @IBOutlet weak var username: UILabel! //评论人
    @IBOutlet weak var commentTextLabel: UILabel! // 评论内容
    @IBOutlet weak var creatTime: UILabel! //评论时间
    @IBOutlet weak var likeBtn: UIButton! // 点赞按钮
    @IBOutlet weak var diggsCount: UILabel! // 点赞数量
    
    // 点赞数量变化检测
    var likeCount: Int = 0 {
        didSet{
            diggsCount.text = likeCount.toWanStr
        }
    }
    
    //是否点赞检测
    var likeTapped: Bool = false {
        didSet{
            if likeTapped {
                likeCount += 1
            }else{
                likeCount -= 1
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
