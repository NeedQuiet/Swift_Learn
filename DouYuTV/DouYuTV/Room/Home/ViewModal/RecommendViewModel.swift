//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by 许一宁 on 2020/6/16.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK: - 懒加载属性
    lazy var AnchorDataItems : [AnchorDataItem] = [AnchorDataItem]() // 推荐页数据数组
    lazy var cycleModels : [CycleModel] = [CycleModel]() // 轮播图Model数组
    private lazy var bigDataGroup : AnchorDataItem = AnchorDataItem() // section 0：热门数据
    private lazy var prettyDataGroup : AnchorDataItem = AnchorDataItem() // section 1: 颜值数据
}

// MARK: - 发送网络请求
extension RecommendViewModel {
    // 请求推荐数据
    func requestData(finishCallback: @escaping () -> ()) {
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        let dispatch_group = DispatchGroup()
        
        
        // 1. 请求 section 0：推荐
        // http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1592381778
        dispatch_group.enter()
        NetworkTools.requestJsonData(URL: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameters:["time":NSDate.getCurrentTime()]) { (isSuccess, Result) in
            if isSuccess {
                // 1. 将result转成字典类型
                guard let resultDict = Result as? [String : NSObject] else { return }
                
                // 2. 根据data，获取数组
                guard let dataArray  = resultDict["data"] as? [[String : NSObject]] else { return }
                
                // 3. 遍历字典，并且转成模型对象
                self.bigDataGroup.tag_name = "热门"
                for dict in dataArray {
                    let anchor = AnchorModel(dict: dict)
                    self.bigDataGroup.Anchors.append(anchor)
                }
            }
            dispatch_group.leave()
            print("请求 section 0：推荐")
        }

        // 2. 请求 section 1：颜值
        // http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1592381778
        dispatch_group.enter()
        NetworkTools.requestJsonData(URL: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters: parameters) { (isSuccess, Result) in
            if isSuccess {
                // 1. 将result转成字典类型
                guard let resultDict = Result as? [String : NSObject] else { return }
                
                // 2. 根据data，获取数组
                guard let dataArray  = resultDict["data"] as? [[String : NSObject]] else { return }
                
                // 3. 遍历字典，并且转成模型对象
                self.prettyDataGroup.tag_name = "颜值"
                for dict in dataArray {
                    let anchor = AnchorModel(dict: dict)
                    self.prettyDataGroup.Anchors.append(anchor)
                }
            }
            dispatch_group.leave()
            print("请求 section 1：颜值")
        }
        
        // 3. 请求 section 2~11：游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1592381778
        dispatch_group.enter()
        NetworkTools.requestJsonData(URL: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: parameters) { (isSuccess, Response) in
            if isSuccess {
                // 1. 将result转成字典类型
                guard let resultDict = Response as? [String : NSObject] else { return }
                
                // 2. 根据data，获取数组
                guard let dataArray  = resultDict["data"] as? [[String : NSObject]] else { return }
                
                // 3. 遍历数组，获取字典，并且将字典转成模型对象
                for dict in dataArray {
                    let data_item = AnchorDataItem(dict: dict)
                    self.AnchorDataItems.append(data_item)
                }
            }
            dispatch_group.leave()
            print("请求 section 2~11：游戏数据")
        }
        // 6.所有数据都请求到，之后进行排序
        dispatch_group.notify(queue: DispatchQueue.main) {
            print("所有数据都请求到")
            self.AnchorDataItems.insert(self.prettyDataGroup, at: 0)
            self.AnchorDataItems.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    // 请求无限轮播的数据
    // http://www.douyutv.com/api/v1/slide/6?version=2.300
    func requestCycleData(finishCallback: @escaping () -> ()){
        NetworkTools.requestJsonData(URL: "http://www.douyutv.com/api/v1/slide/6", method: .GET, parameters: ["version" : "2.300"]) { (isSuccess, Result) in
            if isSuccess {
                // 获取字典数据
                guard let resultDict = Result as? [String : NSObject] else { return }
                
                // 根据data的key获取数据
                guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
                
                // 姊爱你转模型对象
                for dict in dataArray {
                    self.cycleModels.append(CycleModel(dict: dict))
                }
                
                finishCallback()
            }
        }
    }
}
