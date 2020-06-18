//
//  CollectionCycleCell.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/18.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var title: UILabel!
    // MARK: - 模型属性
    var cycleModel: CycleModel? {
        didSet {
            title.text = cycleModel!.title
            let url = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "Img_default"))
        }
    }
}
