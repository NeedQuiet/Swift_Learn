//
//  AnchorModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/17.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

@objcMembers
class AnchorModel: NSObject {
    //房间ID
    var room_id:Int = 0
    //房间封面URL
    var vertical_src:String = ""
    //判断是手机直播还是电脑直播: 0-电脑 1-手机
    var isVertical:Int = 0
    //房间名称
    var room_name:String = ""
    //主播名字
    var nickname:String = ""
    //在线人数
    var online:Int = 0
    //所在城市
    var anchor_city:String = ""
    
    init(dict: [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
