//
//  BaseAnchorViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/23.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: UIViewController {
    //MARK: - 定义属性
    var baseVM : BaseViewModel!
    
    //MARK: - 懒加载属性
    lazy var collectionView: UICollectionView = {[unowned self] in
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2. 创建collectionView
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID) // 普通cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID) // 颜值cell
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID) // header
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth] // view随着控制器拉伸而拉伸
        return collectionView
    }()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}


//MARK: - 设置UI
extension BaseAnchorViewController {
    @objc func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK: - 请求数据
extension BaseAnchorViewController {
    @objc func loadData() {
        print("")
    }
}

// MARK: - UICollectionViewDataSource
extension BaseAnchorViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].Anchors.count
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 取出模型
        let group = baseVM.anchorGroups[indexPath.section]
        let anchor = group.Anchors[indexPath.row]
        
        // 取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionBaseCell
        cell.anchor = anchor
        return cell
    }
    
    // headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出headerView
        let headerView:CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView

        headerView.group = baseVM.anchorGroups[indexPath.section]

        return headerView
    }
}
