//
//  GameViewModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/23.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games: [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        // http://capi.douyucdn.cn/api/v1/getColumnDetail
        // (教程里是http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game，不过参数已失效)
        NetworkTools.requestJsonData(URL: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (isSuccess, Result) in
            // 获取数据
            guard let resultDic = Result as? [String : Any] else { return }
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            // 字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            // 完成回调
            finishedCallback()
        }
    }
}
