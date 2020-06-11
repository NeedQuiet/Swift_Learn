//
//  CommentController.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/21.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CommentController: UIViewController {

    @IBOutlet weak var commentAreaView: UIView! // 评论区域
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelComments: UILabel! // 评论数
    
    var totalComments = 0
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelComments.text = totalComments.description + "条评论"
        
        DouyinNetwork.getComment { (data) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Comments.self, from: data as! Data)
                    OperationQueue.main.addOperation {
                        self.comments = result.comments
                        self.tableView.reloadData()
                    }
                } catch  {
                    print(error)
                }
            }
        }
        
    }
    
    // 按钮
    @IBAction func tapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 背景手势
    @IBAction func tapToDissmiss(_ sender: UITapGestureRecognizer) {
        // 单机手势组件，点击时相当于评论view的位置
        let tapPoint = sender.location(in:commentAreaView)
        // 如果位置不位于评论view之中，则关闭
        if !commentAreaView.layer.contains(tapPoint) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
