//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

private let kPageTitleH: CGFloat = 40

class HomeViewController: UIViewController {
    // MARK: - 懒加载属性
    /*
     闭包设置属性初始值：
     https://daningswift.netlify.app/Learn/Swift-20.html#%E7%BB%93%E6%9E%84%E4%BD%93%E6%88%90%E5%91%98%E5%88%9D%E5%A7%8B%E5%8C%96%E5%99%A8
     */
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleH)
        let titles = ["推荐","游戏","娱乐","去玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.red
        return titleView
    }()
    
    
    // MARK: - 系统构造函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
    }
}

// MARK: 设置UI界面
// extension 类拓展
extension HomeViewController {
    private func setupUI(){
        // 0. 不需要调整UIScollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1. 设置导航栏
        setupNavigationBar()
        
        // 2. 添加TitleView
        view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar () {
        /*
         以下UIBarButtonItem构造方法皆为类拓展构造函数
         */
        
        // 1. 设置左侧Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2. 设置右侧Items
        let size = CGSize(width: 40, height: 40)
        
        // 可以使用拓展类中的类方法去调用，但是不太好看
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
//        let scanItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        // 所以在类拓展中创建了‘构造函数’
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }
}
