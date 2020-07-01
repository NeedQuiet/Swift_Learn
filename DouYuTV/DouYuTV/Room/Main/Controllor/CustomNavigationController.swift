//
//  CustomNavigationController.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/30.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - 自定义全屏pop手势
        //MARK: 获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 获取手势添所在的View
        guard let gesView = systemGes.view else { return }
        
        // 获取target/action
        // 利用运行时机制查看所有的属性名称
        /*
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        
        // (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fa45212d860>)
        guard let targetObjc = targets?.first else { return }
        
        // 取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 取出action
        let action = Selector(("handleNavigationTransition:"))
//        guard let action = targetObjc.value(forKey: "action") as? Selector else { return }
        
        //MARK: 创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        gesView.backgroundColor = UIColor.red
        panGes.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
