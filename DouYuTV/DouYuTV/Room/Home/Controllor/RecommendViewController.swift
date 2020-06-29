//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/15.
//  Copyright © 2020 许一宁. All rights reserved.
//

/**
    首页 - 推荐
 */
import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    // MARK: - 懒加载属性
    // 数据Model
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    // 无限轮播View
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    // 轮播下的game列表
    private lazy var gameView: RecommendGameView = {
        var gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
}

// MARK: - 设置UI界面
extension RecommendViewController {
    override func setupUI() {
        // 先调用super.setupUI()
        super.setupUI()
        collectionView.delegate = self
        // 将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 将gameView添加到UICollectionView中
        collectionView.addSubview(gameView)
        
        // 设置collectionView的内边距，将轮播View显示出来
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension RecommendViewController {
    override func loadData() {
        // 0 给父类中ViewModel赋值
        baseVM = recommendVM
        
        // 1. 请求推荐数据
        recommendVM.requestData {
            // 展示数据
            self.collectionView.reloadData()
            
            
            var groups = self.recommendVM.anchorGroups
            // 删除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 添加”更多“
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            // 传给GameView
            self.gameView.groups = groups
        }
        
        // 2. 请求轮播数据
        recommendVM.requestCycleData {
            // 把请求到的数据传给cycleView
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecommendViewController{
    // 重新父类的cell和headerView方法
    // cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
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
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出headerView
        let headerView:CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.backgroundColor = UIColor.gray
        
        headerView.group = recommendVM.anchorGroups[indexPath.section]

        if indexPath.section == 0 {
            headerView.imageView.image = UIImage(named: "home_header_hot")
        }else if indexPath.section == 1{
            headerView.imageView.image = UIImage(named: "home_header_phone")
        }
        return headerView
    }
}

// Item Size
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
