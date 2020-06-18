//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/18.
//  Copyright © 2020 许一宁. All rights reserved.
//

/**
   首页 - 推荐 - 无限轮播
*/

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    // MARK: - 定义属性
    var cycleTimer: Timer?
    
    var cycleModels: [CycleModel]? {
        didSet {
            collectionView.reloadData()
            
            // 设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            // 默认滚动到中间某一个位置
            let indexPath = NSIndexPath(row: (cycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            // 添加定时器
            addCycleTimer()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    // MARK: - 控件属性


    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸，不然由于父控件大小压缩导致无法显示
        autoresizingMask = []
        
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置layout (这里拿到的才是准确的，awakeFromNib拿到的是xib中的尺寸，不准确)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

// MARK: - 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView () -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: - UICollectionViewDataSource
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量 （pageControl滚一半就可以跳到下一个）
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5
        // 2.计算currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.size.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removerCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: - 对定时器的操作方法
extension RecommendCycleView {
    private func addCycleTimer() {
        removerCycleTimer()
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    private func removerCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        // 获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.size.width
        
        // 滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
