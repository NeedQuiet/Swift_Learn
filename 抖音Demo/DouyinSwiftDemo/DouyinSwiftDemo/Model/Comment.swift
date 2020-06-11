//
//  Comment.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/21.
//  Copyright © 2020 许一宁. All rights reserved.
//

import Foundation

// 评论
struct Comment: Codable {
    var text : String // 评论
    var digg_count : Int // 点赞数
    var create_time : Int // 时间
    var user :User
    var reply_comment : [Comment]? // 评论下的追评
}

// 评论数
struct Comments:Codable {
    var comments : [Comment]
}
