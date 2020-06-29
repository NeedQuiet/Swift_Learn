//
//  AmuseViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/23.
//  Copyright © 2020 许一宁. All rights reserved.
//

/**
   首页 - 娱乐
*/

import UIKit

private let kMenuViewH: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    private lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    // 娱乐HeaderView
    private lazy var menuView: AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        menuView.autoresizingMask = []
        return menuView
    }()
}

extension AmuseViewController {
    // 请求数据
    override func loadData() {
        // 给父类中view model 赋值
        baseVM = amuseVM
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
        }
    }
    
    override func setupUI() {
        super.setupUI()
        // 添加菜单View
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


