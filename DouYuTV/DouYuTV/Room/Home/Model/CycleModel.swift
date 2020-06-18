//
//  CycleModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/18.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    // 房间ID
    @objc var id: Int = 0
    // 轮播图
    @objc var pic_url: String = ""
    // 标题
    @objc var title: String = ""
    // 主播信息对应的字典
    @objc var room : [String : NSObject]?{
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    var anchor : AnchorModel?
    
    
    // MARK: - 自定义构造函数
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
