//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

private let kScollLineH:CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (225, 128, 0)

class PageTitleView: UIView {

    // MARK: - 定义属性
    private var titles: [String]
    private var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
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
    
    // MARK: - 标题TitleLabels
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            
            // 3. 设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 4. 将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5. 给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    // MARK: - 底线及下划线
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
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScollLineH, width: firstLabel.frame.width, height: kScollLineH)
    }
}

// MAEK: - 监听Label的点击
extension PageTitleView{
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        // 1. 获取当前Label
        let currentLabel = tapGes.view as! UILabel
        
        // 重复点击就截停
        if currentIndex == currentLabel.tag { return }
        
        // 2. 获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        // 3. 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 4. 保存最新Label的Index
        currentIndex = currentLabel.tag
        
        // 5. 滚动条位置变化
        let scollLineX = CGFloat(currentIndex) * scrollLine.frame.size.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scollLineX
        }
        
        // 6. 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

// MARK: - 对外暴露的方法
extension PageTitleView {
    // 改变线的位置和label的状态
    func pageTitleViewScroll(from: Int, to: Int, progress: CGFloat){
        let fromLabel:UILabel = titleLabels[from]
        let targetLabel:UILabel = titleLabels[to]
        // 线的位置
        if from < to { // 左滑
            scrollLine.frame.origin.x = (progress + CGFloat(from)) * scrollLine.frame.size.width
        }else if from > to {
            scrollLine.frame.origin.x = (CGFloat(from) - progress) * scrollLine.frame.size.width
        }
        
        
        fromLabel.textColor = UIColor(r: kSelectColor.0 - (kSelectColor.0 - kNormalColor.0) * progress,
                                      g: kSelectColor.1 - (kSelectColor.1 - kNormalColor.1) * progress,
                                      b: kSelectColor.2 + (kNormalColor.2 - kSelectColor.2) * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + (kSelectColor.0 - kNormalColor.0) * progress,
                                        g: kNormalColor.1 + (kSelectColor.1 - kNormalColor.1) * progress,
                                        b: kNormalColor.2 - (kNormalColor.2 - kSelectColor.2) * progress)
        currentIndex = to
    }
}
