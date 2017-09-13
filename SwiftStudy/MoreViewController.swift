//
//  MoreViewController.swift
//  SwiftStudy
//
//  Created by xiejinke on 2016/11/24.
//  Copyright © 2016年 wy. All rights reserved.
//

import Foundation
import UIKit


class MoreViewController: UIViewController {
    var news:Dictionary<String, Any> = [:]
    private var url = ""
    var webView = UIWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(back))
        
        
        /*
        let title = self.news["title"] as? String
//        self.title = title.substring(to: title.index(title.startIndex, offsetBy: 20))
        self.title = title
        
        self.url = (self.news["url"] as? String)!
        
        self.webView.frame = self.view.frame
        let request = URLRequest(url: URL(string: self.url)!)
        self.webView.loadRequest(request)
        self.view.addSubview(webView)
        
        self.view.addConstraint(NSLayoutConstraint.init(item: webView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: webView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0))
        webView.translatesAutoresizingMaskIntoConstraints = false
         */
    }
    
    func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        Logger.log(item: "deinit")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
