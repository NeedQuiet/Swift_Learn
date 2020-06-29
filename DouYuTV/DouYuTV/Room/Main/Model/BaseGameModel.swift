//
//  BaseGameModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/23.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

@objcMembers
class BaseGameModel: NSObject {
    // 房间名
    var tag_name: String = ""
    
    // 图标
    var icon_url: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)// 根据dict给此class中的对应属性赋值(需配合@objcMembers或者@objc)
    }
    
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
