//
//  AmuseViewModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/23.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    
}

extension AmuseViewModel {
    // http://capi.douyucdn.cn/api/v1/getHotRoom/2
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
