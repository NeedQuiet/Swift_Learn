//
//  NSDate-Extension.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/17.
//  Copyright © 2020 许一宁. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
        
        
    }
}
