//
//  PageContentView.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentDicScroll(contentView: PageContentView , fromIndex: Int, targetIndex: Int, progress: CGFloat)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    // MARK: - 定义属性
    private var childVCs : [UIViewController] // 子VC数组，collectionView数据源
    
    /*
     弱引用是因为外面的HomeViewController强引用了PageContentView，
     如果这里的parentVC也使用强引用指向外部的HomeViewController，那么就会循环引用，对象会无法销毁
     */
    private weak var parentVC : UIViewController?
    
    // 用于记录滑动时坐标
    private var movingOffsetX: CGFloat = 0
    
    weak var delegate: PageContentViewDelegate?
    
    private lazy var collectionView: UICollectionView = { [weak self] in // 闭包里的self要使用弱引用，类似block
        // 1. 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2. 创建UIContentView
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()

    // MARK: - 自定义构造函数
    init(frame:CGRect,childVCs: [UIViewController],parentVC:UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame:frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension PageContentView {
    private func setupUI() {
        // 1. 将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            parentVC?.addChild(childVC)
        }
        
        // 2. 添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: - UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2. 给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        movingOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1. 定义数据
        var progress: CGFloat = 0 // 进度
        var fromIndex: Int = 0 // 老Index
        var targetIndex: Int = 0 // 目标Index
        
        // 2. 判断是左滑还是右滑 同时计算：滑动进度、fromIndex、targetIndex
        let currentOffsetX = scrollView.contentOffset.x // scrollView已滑动距离
        progress = currentOffsetX / bounds.size.width // 小数部分为进度
        
        if currentOffsetX > movingOffsetX { // 左滑向右滚
            fromIndex = Int(progress)
            targetIndex = fromIndex + 1
            /**
                滑动结束时，fromIndex会+1，所以要做额外判断
             */
            if progress == CGFloat(fromIndex) {
                progress = 1
                fromIndex -= 1
                targetIndex -= 1
            }else{
                progress = progress - CGFloat(fromIndex)
            }
            if fromIndex >= childVCs.count - 1 { // 防止数组越界
                return
            }
        }else if currentOffsetX < movingOffsetX{ // 右滑向左滚
            fromIndex = Int(progress) + 1
            targetIndex = fromIndex - 1
            progress =  CGFloat(fromIndex) - progress
        }
        movingOffsetX = currentOffsetX
        
        
        // 3. 通知代理
        delegate?.pageContentDicScroll(contentView:self ,fromIndex: fromIndex, targetIndex: targetIndex, progress: progress)
    }
}

// MARK: - 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex: Int) {
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}
