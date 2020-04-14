//
//  ViewController.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/10.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    
    var awemeList = [AwemeList]()
    var videoJsonIndex = 12
    var currentPage = 0
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UIScreen.main.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return awemeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell

        cell.aweme = awemeList[indexPath.row]

        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadingView.startAnimating()
        getList()
    }
    
    // 拖动结束
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        videoJsonIndex -= 1
        if videoJsonIndex <= 0 {
            videoJsonIndex = 12
        }
        debugPrint("index" ,videoJsonIndex)
        getList()
        
        currentPage = tableView.indexPathsForVisibleRows!.last!.row
        debugPrint("页码:",currentPage)
    }
    
    func getList() {
        let url = URL(string: DouyinURL.baseLocal + videoJsonIndex.description + DouyinURL.feedFile)!
        getAwelist(url: url)
        
    }

    func getAwelist(url: URL) {
        do {
            let feed = try Feed(fromURL: url)
            if let awemeList = feed.awemeList {
                self.awemeList += awemeList
                self.loadingView.stopAnimating()
                self.tableView.reloadData()
            }
        } catch {
            debugPrint("解析错误",error)
        }
    }

}

