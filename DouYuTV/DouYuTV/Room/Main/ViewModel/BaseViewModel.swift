//
//  BaseViewModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/23.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(URLString: String , isGroupData: Bool? = true, parameters: [String : String]? = nil, finishedCallback: @escaping () -> ()) {
        NetworkTools.requestJsonData(URL: URLString, parameters: parameters) { (isSuccess, result) in
            guard let resultDic = result as? [String : Any] else { return }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 判断是否是GroupData (FunnyViewModel返回的data是个数组，其余的都是详细的分组(section)数据)
            if isGroupData == true { // 很多section
                // 遍历字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else { // 只有1个section，例如趣玩页
                // 既然没有section，那就自己创建1个section，然后把请求的数据都塞进去
                let group = AnchorGroup()
                for dict in dataArray {
                    group.Anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            
            finishedCallback()
        }
    }
}
