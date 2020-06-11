//
//  DouyinNetwork.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/10.
//  Copyright © 2020 许一宁. All rights reserved.
//

import Foundation
import Just

struct DouyinURL {
    static let baseLocal = "http://localhost:52330/"
    static let feedFile = "feed.json"
    
    static let commentLocal = URL(string: baseLocal + "/comment/xsy.json")!
}

typealias Success = () -> Void
typealias SuccessWithJson = (Any?) -> Void

struct DouyinNetwork {
    static let ERR = "Json获取错误："
    
    // 获取本地评论的Json
    static func getComment(success: @escaping SuccessWithJson) {
        DouyinNetwork.getJson(url: DouyinURL.commentLocal, success: success)
    }
    
    static func getJson(url:URL, success: @escaping SuccessWithJson) {
        Just.get(url) { (r) in
            if r.ok {
                success(r.content)
            }else{
                debugPrint(DouyinNetwork.ERR,r.reason)
            }
        }
    }
}
