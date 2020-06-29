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
    func loadAnchorData(URLString: String ,parameters: [String : String]? = nil, finishedCallback: @escaping () -> ()) {
        NetworkTools.requestJsonData(URL: URLString, parameters: parameters) { (isSuccess, result) in
            guard let resultDic = result as? [String : Any] else { return }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 遍历字典
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            finishedCallback()
        }
    }
}
