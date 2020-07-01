//
//  FunnyViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/29.
//  Copyright © 2020 许一宁. All rights reserved.
//

/**
   首页 - 趣玩
*/

import UIKit

private let kTopMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    //MARK: - 懒加载ViewModel对象
    private lazy var funnyVM: FunnyViewModel = FunnyViewModel()

}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        
        // 给父类ViewModel赋值
        baseVM = funnyVM
        
        // 请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            // 数据请求完成
            self.loadDataFinished()
        }
    }
}
