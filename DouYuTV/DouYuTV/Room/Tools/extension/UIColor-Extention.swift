//
//  UIColor-Extention.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
    }
}
