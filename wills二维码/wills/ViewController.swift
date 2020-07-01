//
//  ViewController.swift
//  wills
//
//  Created by 许一宁 on 2020/7/1.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var codeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.startGet()
    }
    
    func startGet() {
        let now = NSDate()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        print(timeInterval)
        
        var timeStamp = String(timeInterval)
        timeStamp = timeStamp.replacingOccurrences(of: ".", with: "")
        timeStamp = String(timeStamp.prefix(13))
        
        
        let url: String = "https://memberapp.willsfitness.net/app/user/getEntryCode?_r=\(timeStamp)"
        print(url)
        NetworkTools.requestJsonData(URL: url) { (isSuccess, result) in
            if isSuccess {
                guard let resultDic = result as? [String : Any] else { return }
                guard let data = resultDic["data"] as? [String : Any] else { return }
                guard let code = data["code"] else { return }
                
                self.getEWCode(code: code as! String)
            }
        }
    }
    
    func getEWCode(code: String) {
        print("code: \(code)")
        let url: String = "https://memberapp.willsfitness.net/app/barcode?text=\(code)"
        NetworkTools.requestData(URL: url) { (isSuccess, result) in
            if isSuccess {
                let image = UIImage(data: result as! Data)
                self.codeImageView.image = image
            }
        }
    }

    @IBAction func click(_ sender: Any) {
        self.startGet()
    }
}

