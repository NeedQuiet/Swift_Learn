//
//  User.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/21.
//  Copyright © 2020 许一宁. All rights reserved.
//

import Foundation

struct User: Codable {
    var nickname : String // 用户名
    var avatar_thumb : String
    
}

struct Avatar_thumb:Codable {
    var url_list : [String] //头像列表
}
