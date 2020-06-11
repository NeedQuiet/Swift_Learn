//
//  UIBarButtonItem-Extension.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import Foundation
import UIKit


extension UIBarButtonItem{
    // 创建类方法：可以直接用类去调用，比较方便，但是使用不太好看
    class func createItem(imageName: String, highImageName : String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    /** 便利构造函数：
     1. 必须以convenience开头
     2. 在构造函数中必须明确调用一个设计的构造函数(self)
     3. 调用示例：UIBarButtonItem(imageName: "AAA", highImageName: "BBB", size: size)
     */
    convenience init(imageName: String, highImageName : String = "", size: CGSize = CGSize(width: 0, height: 0)) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size != CGSize(width: 0, height: 0)  {
            btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
        self.init(customView:btn)
    }
    
}
