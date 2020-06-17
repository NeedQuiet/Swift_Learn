//
//  AnchorDataItem.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/17.
//  Copyright © 2020 许一宁. All rights reserved.
//

/*
    主播分组模型
 */
import UIKit

/*
    在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
    在swift5中，编译器不再自动推断，你必须手动添加@objc，或者@objcMembers
    详情参考简书：https://www.jianshu.com/p/2cef1e80042c
 */
@objcMembers
class AnchorDataItem: NSObject {
    // 改组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        // 可以用属性监听器，也可以用下面的KVC方法
        didSet {
            guard let list_value = room_list else { return }
            for dict in list_value {
                Anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // 组标题
    var tag_name : String = ""
    // 组图标
    var icon_url : String = ""
    
    // 懒加载RoomList模型
    lazy var Anchors: [AnchorModel] = [AnchorModel]()
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict) // 根据dict给此class中的对应属性赋值
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        // 防止init时，此class不包含传入dic的某些属性，因此重写此方法即可
    }
    
    override init() {
        
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let list_value = value as? [[String : NSObject]] {
//                for dict in list_value {
//                    Anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//    }
}
