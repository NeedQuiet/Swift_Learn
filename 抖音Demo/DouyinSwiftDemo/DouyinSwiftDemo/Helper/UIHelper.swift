//
//  UIHelper.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/12.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

extension UIView {
    // 用 @IBInspectable public，xib里会增加corerRadius属性
    @IBInspectable public var corerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var boarderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
