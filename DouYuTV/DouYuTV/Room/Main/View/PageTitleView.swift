//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

private let kScollLineH:CGFloat = 2

class PageTitleView: UIView {

    // MARK: - 定义属性
    private var titles: [String]
    
    // MARK: - 懒加载属性
    // 存放labels的数组
    private lazy var titleLabels: [UILabel] = [UILabel]()
    // scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false // 隐藏滚动条
        scrollView.scrollsToTop = false // 取消点击状态栏滚回顶部
        scrollView.bounces = false // 不允许超过范围
        return scrollView
    }()
    // 滚动的线
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect , titles :[String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    // 如果自定义了构造函数，这个required init是必须实现的
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension PageTitleView {
    private func setupUI(){
        // 1. 添加UIScrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        
        // 2. 添加title对应的label
        setupTitleLabels()
        
        // 3. 设置底线和滚动滑块
        setupBottomScrollLine()
    }
    
    private func setupTitleLabels(){
        // 设置label的frame
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            // 1. 创建label
            let label = UILabel()
            
            // 2. 设置label的属性
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            
            // 3. 设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 4. 将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomScrollLine(){
        // 1. 创建底线backView
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2. 添加scrollLine
        // 拿到第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScollLineH, width: firstLabel.frame.width, height: kScollLineH)
    }
}
