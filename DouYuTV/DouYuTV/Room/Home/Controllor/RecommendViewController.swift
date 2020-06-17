//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/15.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    // MARK: - 属性
    
    // MARK: - 懒加载属性
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    private lazy var collectionView: UICollectionView = {[unowned self] in
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2. 创建collectionView
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID) // 普通cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID) // 颜值cell
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID) // header
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth] // view随着控制器拉伸而拉伸
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
        // 发送网络请求
        loadData()
    }
}

// MARK: - 设置UI界面
extension RecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK: - 请求数据
extension RecommendViewController {
    private func loadData() {
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.AnchorDataItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.AnchorDataItems[section]
        
        return group.Anchors.count
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 取出模型
        let group = recommendVM.AnchorDataItems[indexPath.section]
        let anchor = group.Anchors[indexPath.row]
        
        // 2. 取出cell
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        }else{
            cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        cell.anchor = anchor
        return cell
    }
    
    // headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出headerView
        let headerView:CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.backgroundColor = UIColor.gray
        
        headerView.group = recommendVM.AnchorDataItems[indexPath.section]

        if indexPath.section == 0 {
            headerView.imageView.image = UIImage(named: "home_header_hot")
        }else if indexPath.section == 1{
            headerView.imageView.image = UIImage(named: "home_header_phone")
        }
        return headerView
    }
}

// MARK: - UICollectionViewDelegate/UICollectionViewDelegateFlowLayout
extension RecommendViewController : UICollectionViewDelegate {
}
// Item Size
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
