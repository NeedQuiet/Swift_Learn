//
//  AmuseMenuViewCell.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/29.
//  Copyright © 2020 许一宁. All rights reserved.
//
/**
   首页 - 娱乐 - header - cell
*/

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    //MARK: - 属性
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - 从xib加载
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}

extension AmuseMenuViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups?[indexPath.row]
        cell.bottomLine.isHidden = true
        return cell
    }
    
    
}
