//
//  GameViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/23.
//  Copyright © 2020 许一宁. All rights reserved.
//

/**
   首页 - 游戏
*/

import UIKit

private let kEdgeMargin: CGFloat = 10 // 边缘外边距
private let kItemW: CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH: CGFloat = kItemW * 6 / 5
private let kHeaderViewH: CGFloat = 50
private let kGameViewH: CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kGameCellHeader = "kGameCellHeader"

class GameViewController: BaseViewController {

    //MARK: - 懒加载属性
    // 底部60组数据的collectionView
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: kGameCellHeader)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    // game数据的view model
    private lazy var gameVM : GameViewModel = GameViewModel()
    // 顶部headerView
    private lazy var topHeadeView: CollectionHeaderView = {
        let header = CollectionHeaderView.collectionHeaderView()
        header.frame = CGRect(x: 0, y: -kHeaderViewH - kGameViewH, width: kScreenW, height: kHeaderViewH)
        header.imageView.image = UIImage(named: "Img_orange")
        header.titleLabel.text = "常见"
        header.moreButton.isHidden = true
        return header
    }()
    
    // 轮播下的game列表
    private lazy var gameView: RecommendGameView = {
        var gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        loadData()
    }
}

//MARK: - 设置UI界面
extension GameViewController {
    override func setupUI() {
        // 1. 给父类contentView赋值，方便控制显示隐藏
        contentView = collectionView
        
        // 2. 添加collectionView
        view.addSubview(collectionView)
        
        // 3. 调用super（保证contentView有值）
        super.setupUI()

        // 添加顶部的headerView
        collectionView.addSubview(topHeadeView)
        // 顶部headerView下面继续添加gameView
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension GameViewController {
    private func loadData() {
        gameVM.loadAllGameData {
            // 展示全部游戏
            self.collectionView.reloadData()
            
            // 展示常用游戏
            let games = self.gameVM.games
            let min = [games.count , 10].min() ?? 0
            let groups = games[0..<min]

            self.gameView.groups = Array(groups)
            
            // 数据请求完成
            self.loadDataFinished()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return [gameVM.games.count , 60].min() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell

        let gameModel = gameVM.games[indexPath.row]
        
        cell.baseGame = gameModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameCellHeader, for: indexPath) as! CollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.imageView.image = UIImage(named: "Img_orange")
        headerView.moreButton.isHidden = true
        return headerView
    }
}
