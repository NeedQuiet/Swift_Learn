//
//  FunnyViewModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/30.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/1", isGroupData: false, parameters: ["limit" : "30", "offset" : "0"], finishedCallback: finishedCallback)
    }
}
