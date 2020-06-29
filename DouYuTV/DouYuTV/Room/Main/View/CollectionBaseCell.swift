//
//  CollectionBaseCell.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/17.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
   // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    // 定义模型
    var anchor: AnchorModel? {
        didSet {
           guard let anchor = anchor else { return }
            // 在线人数
            var onlineStr:String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            // 名称
            nickName.text = anchor.nickname
            
            // 封面
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src),placeholder:UIImage(named: "Img_default") )
        }
    }
}
