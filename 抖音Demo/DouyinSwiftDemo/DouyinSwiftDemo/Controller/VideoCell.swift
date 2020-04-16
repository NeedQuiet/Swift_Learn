//
//  VideoCell.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import MarqueeLabel
import Kingfisher
import ChainableAnimations

class VideoCell: UITableViewCell {
    var animator1: ChainableAnimator!
    var animator2: ChainableAnimator!
    
    var aweme : AwemeList!{
        didSet{
            lableAuthor.text = aweme.author!.nickname
            labelDescription.text = aweme.desc!
            
            // 设置视频封面
            let cover = aweme.video!.cover!.urlList![0]
            let coverUrl = URL(string: cover)!
            coverImageView.kf.setImage(with: coverUrl)
            
            //设置音乐标题和作者
            labelMusic.text = aweme.music!.title! + " - " + aweme.music!.author!
            
            //作者头像按钮
            let authorAvatar = aweme.author!.avatarThumb!.urlList![0]
            let authorUrl = URL(string: authorAvatar)!
            followBtn.kf.setImage(with: authorUrl, for: .normal)

            //点赞 评论 转发
            likeNum.text = aweme.statistics!.diggCount!.toWanStr
            commentNum.text = aweme.statistics!.commentCount!.toWanStr
            shareNum.text = aweme.statistics!.shareCount!.toWanStr
            
            //唱盘音乐封面
            let musicCover = aweme.music!.coverThumb!.urlList![0]
            musicCoverImageView.kf.setImage(with: URL(string: musicCover))
            
            animator2 = ChainableAnimator(view: diskSubView)
            animator2.rotate(angle: 180).animateWithRepeat(t: 3.5, count: 50)
            
            // 音符散发动画
            diskView.raiseAnimate(imaName: "icon_home_musicnote1", delay: 0)
            diskView.raiseAnimate(imaName: "icon_home_musicnote2", delay: 1)
            diskView.raiseAnimate(imaName: "icon_home_musicnote1", delay: 2)
        }
    }
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var pauseImageView: UIImageView!
    
    @IBOutlet weak var lableAuthor: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelMusic: MarqueeLabel!
    
    // 头像
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var addFollowBtn: UIButton!
    
    // 收藏
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likeNum: UILabel!
    
    // 评论
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var commentNum: UILabel!
    
    // 分享
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareNum: UILabel!
    
    // 唱盘
    @IBOutlet weak var diskView: UIView!
    @IBOutlet weak var diskSubView: UIView!
    @IBOutlet weak var musicCoverImageView: UIImageView!
    @IBOutlet weak var rotateDiskView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // cell重用时的方法
    override func prepareForReuse() {
        // 重置状态
        if animator1 != nil {
            animator1.stop()
            addFollowBtn.transform = .identity
            addFollowBtn.layer.removeAllAnimations()
            addFollowBtn.setImage(UIImage(named: "icon_personal_add_little"), for: .normal)
        }
        
        diskView.resetAnimation()
    }

    
    @IBAction func addFollowTap(_ sender: UIButton) {
        
        animator1 = ChainableAnimator(view: sender)
        // options 选转场
        UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve, animations: {
            sender.setImage(UIImage(named: "iconSignDone"), for: .normal)
        }) { (_) in
            self.animator1.rotate(angle: 360).thenAfter(t: 0.3).wait(t: 0.3).transform(scale: 0).animate(t: 0.2)
        }
    }
}
