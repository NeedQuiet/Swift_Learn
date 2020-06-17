//
//  CollectionHeaderView.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/15.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var group : AnchorDataItem? {
        didSet {
            titleLabel.text = group?.tag_name
            let url = URL(string: group?.icon_url ?? "")
            let image = UIImage(named: "home_header_normal")
            imageView.kf.setImage(with: url, placeholder: image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
