//
//  BaseViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/30.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK: 定义属性
    var contentView: UIView?

    //MARK: 懒加载属性
    fileprivate lazy var animImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration  = 0.5
        imageView.animationRepeatCount = LONG_MAX // 无穷大
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    //MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension BaseViewController {
    @objc func setupUI() {
        // 1.隐藏内容的View
        contentView?.isHidden = true
        
        // 2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        
        // 3.animImageView执行动画
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        // 1. 停止动画
        animImageView.stopAnimating()
        // 2. 隐藏animImageView
        animImageView.isHidden = true
        // 3. 显示内容页
        contentView?.isHidden = false
    }
}

