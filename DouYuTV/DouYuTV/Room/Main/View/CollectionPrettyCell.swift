//
//  CollectionPrettyCell.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/15.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    // MARK: - 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // 定义属性
    override var anchor: AnchorModel? {
        didSet {
            // 将属性传给父类
            super.anchor = anchor
            // 城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
