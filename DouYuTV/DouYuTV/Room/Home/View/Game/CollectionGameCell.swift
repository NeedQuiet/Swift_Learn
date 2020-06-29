//
//  CollectionGameCell.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/18.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    
    var baseGame: BaseGameModel? {
        didSet {
            title.text = baseGame?.tag_name
            let url = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
