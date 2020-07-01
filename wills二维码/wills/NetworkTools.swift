//
//  NetworkTools.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/16.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
//  测试： http://httpbin.org/get 
    class func requestJsonData(URL : String,
                           method: MethodType? = .GET,
                           parameters : [String : String]? = nil,
                           finishCallBack : @escaping (_ iSuccess: Bool ,_ result : Any) -> ()) {
        // 1. 获取类型
        let httpMethod = method == .GET ? HTTPMethod.get : HTTPMethod.post
        
        // 2. 发送网络请求
        
        // 模拟
        let headers: HTTPHeaders = [
            "User-Agent":"Willsapp iPhone iPhone11,8 , 13.5.1 token[tevsiwqobomg]"
        ]
        AF.request(URL, method: httpMethod, parameters: parameters, headers: headers)
            .responseJSON { response in
            switch response.result {
            case let .success(success):
                finishCallBack(true, success)
            case let .failure(error):
                finishCallBack(false, error)
            }
        }
    }
    
    class func requestData(URL : String,
                               method: MethodType? = .GET,
                               parameters : [String : String]? = nil,
                               finishCallBack : @escaping (_ iSuccess: Bool ,_ result : Any) -> ()) {
            // 1. 获取类型
            let httpMethod = method == .GET ? HTTPMethod.get : HTTPMethod.post
            
            // 2. 发送网络请求
            
            // 模拟
            let headers: HTTPHeaders = [
                "User-Agent":"Willsapp iPhone iPhone11,8 , 13.5.1 token[tevsiwqobomg]"
            ]

            AF.request(URL, method: httpMethod, parameters: parameters, headers: headers)
                .responseData { (response) in
                switch response.result {
                case let .success(success):
                    finishCallBack(true, success)
                case let .failure(error):
                    finishCallBack(false, error)
                }
                    
            }
        }
}
