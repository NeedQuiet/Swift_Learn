//
//  Helper.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/11.
//  Copyright © 2020 许一宁. All rights reserved.
//

import Foundation

// 处理过万的数字
extension Int{
    var toWanStr: String{
        if self > 10000{
            // 把self转为小数
            let a = Double(exactly: self)! / 10000.0
            // 四舍五入，并转为字符串
            return round(a).description + "W"
        }
        return self.description
    }
}
