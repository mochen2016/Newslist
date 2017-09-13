//
//  ViewController.swift
//  SwiftStudy
//
//  Created by xiejinke on 2016/11/15.
//  Copyright © 2016年 wy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate {
    
    var dataSource:Array<Any> = []
    
    var table:UITableView = UITableView()
    
    let model = requestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        
        let lbtn = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        self.navigationItem.leftBarButtonItem = lbtn
        
        let rbtn = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.navigationItem.rightBarButtonItem = rbtn

        
        initViews()
        
        model.num = 10
        model.page = 1
        model.rand = 1;
        model.src = "人民日报"
        model.word = "鬼吹灯"
//        loadDataSource()
        
        
        
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == 0x10 {
            if alertView.cancelButtonIndex != buttonIndex {
                let tf = alertView.textField(at: 0)
                self.model.word = (tf?.text!)!
                self.model.num = 10
                self.model.page = 1
                self.model.rand = 1;
                self.model.src = "人民日报"
                self.loadDataSource()
            }
        }
    }
    
    func edit() {
        let alert = UIAlertView.init(title: "input", message: "", delegate: self, cancelButtonTitle: "cancel", otherButtonTitles: "ok")
        alert.alertViewStyle = .plainTextInput
        alert.tag = 0x10
        alert.show()
    }
    
    func refresh() {
//        loadDataSource()
        
        
        

        let web = MoreViewController()

//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationCurve(.easeInOut)
//        UIView.setAnimationDuration(0.75)
//        self.navigationController?.pushViewController(web, animated: false)
//        UIView.setAnimationTransition(.curlUp, for: (self.navigationController?.view)!, cache: false)
//        UIView.commitAnimations()
        let naVC = UINavigationController.init(rootViewController: web)
        
        self.present(naVC, animated: true, completion: {()->Void in
            
        })
    }
    
    func initViews() {
        self.table = UITableView.init(frame: self.view.frame, style: .plain)
        self.table.delegate = self
        self.table.dataSource = self
        self.view.addSubview(self.table)
        
        self.view.addConstraint(NSLayoutConstraint.init(item: self.table, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: self.table, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0))
        self.table.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func loadDataSource() {
        ServerInterface.requestContent(model: model, completion: {(respData,error)->Void in
            
            print("\(String(describing: respData))")
            
            func alertError(msg:String,code:Int) {
                let alert = UIAlertView.init(title: "error:\(code)", message: msg, delegate: nil, cancelButtonTitle: "ok" )
                alert.show()
            }
            
            if respData != nil  {
                let data = respData?.data(using: .utf8)
                let dic = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, Any>
                
                let newsList = dic["newslist"] as? Array<Any>
                print("\(String(describing: newsList))")
                
                if newsList != nil {
                    self.dataSource = newsList!
                    self.table.reloadData()
                    
                }else {
                    alertError(msg: dic["msg"] as! String, code: dic["code"] as! Int);
                }
            }else {
                alertError(msg: error.debugDescription, code: -1)
            }
    
        })

    }
    
    
    deinit {
        
    }
    
    //MARK: - table delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }

        let news = self.dataSource[indexPath.row] as! Dictionary<String,Any>
        
        
        let imageData = NSData(contentsOf: URL(string:news["picUrl"] as! String)!)
        let image = UIImage(data:imageData as! Data)
        
        let size = CGSize(width:44,height:44)
        cell?.imageView?.image = image?.reSizeImage(reSize: size)
            
        cell?.textLabel?.text = news["description"] as! String?
        

        cell?.detailTextLabel?.text =  news["title"] as! String?
        
        
//        cell.setNews(news: news)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = self.dataSource[indexPath.row] as! Dictionary<String,Any>
        let web = MoreViewController()
        web.news = news
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationDuration(0.75)
        self.navigationController?.pushViewController(web, animated: false)
        UIView.setAnimationTransition(.curlDown, for: (self.navigationController?.view)!, cache: false)
        UIView.commitAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



class CustomCell: UITableViewCell {
    var timeLable:UILabel?
    var titleLabel:UILabel?
    var descriptionLabel:UILabel?
    var picImgView:UIImageView?
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI();
    }
    
    func setUpUI() {
        
        let cellWidth = self.frame.width
        let cellHeight = self.frame.height
        
        self.picImgView = UIImageView()
        self.picImgView?.frame = CGRect(x:0, y:0, width:cellHeight, height:cellHeight)
        self.addSubview(self.picImgView!)
        
        self.titleLabel = UILabel.init()
        self.titleLabel?.backgroundColor = UIColor.clear;
        self.titleLabel?.frame = CGRect(x:(self.picImgView?.frame.width)!, y:0, width:cellWidth-(self.picImgView?.frame.size.width)!, height:30)
        self.titleLabel?.textColor = UIColor.black
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.addSubview(self.titleLabel!)
        
        self.descriptionLabel = UILabel.init()
        self.descriptionLabel?.backgroundColor = UIColor.clear;
        self.descriptionLabel?.frame = CGRect(x:(self.picImgView?.frame.width)!, y:(self.titleLabel?.frame.origin.y)!+(self.titleLabel?.frame.size.height)!, width:(self.titleLabel?.frame.width)!, height:30)
        self.descriptionLabel?.textColor = UIColor.black
        self.descriptionLabel?.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel?.textAlignment = .center
        self.addSubview(self.descriptionLabel!)
        
    }
    
    func setNews(news:Dictionary<String,Any>) {
        let imageData = NSData(contentsOf: URL(string:news["picUrl"] as! String)!)
        self.picImgView?.image = UIImage(data:imageData as! Data)
        
        self.titleLabel?.text = news["description"] as! String?
        
        self.descriptionLabel?.text =  news["title"] as! String?
    }
    
}

