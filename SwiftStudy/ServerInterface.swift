//
//  ServerInterface.swift
//  SwiftStudy
//
//  Created by xiejinke on 2016/12/2.
//  Copyright © 2016年 wy. All rights reserved.
//

import Foundation

let baseUrl = "http://apis.baidu.com/txapi/weixin/wxhot"

let apikey = "11d7e729fbaec89d9a294c1ef52aa9e3";

class ServerInterface: NSObject {
    
    
    class func requestContent(model:requestModel, completion:@escaping (String?,Error?)->Void) {
        let queryItem1 = URLQueryItem(name: "word", value:model.word)
        let queryItem2 = URLQueryItem(name: "src", value:model.src)
        let urlComponents = NSURLComponents(string: baseUrl)!
        urlComponents.queryItems = [queryItem1,queryItem2]
        let regURL = urlComponents.url!
        let url = "\(regURL)&num=\(model.num)&rand=\(model.rand)&page=\(model.page)"
        var request = URLRequest(url: URL(string:url)!)
        request.httpMethod = "GET"
        request.addValue(apikey, forHTTPHeaderField: "apikey")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request,
                                        completionHandler: {(data, response, error) -> Void in
                                            DispatchQueue.main.async {
                                                if error != nil{
                                                    print(error.debugDescription)
                                                    completion(nil,error)
                                                }else{
                                                    let str = String(data: data!, encoding: String.Encoding.utf8)
                                                    print(str ?? "null")
                                                    completion(str,nil)
                                                }
                                            }
                                            
                                            
                                            
        })
        
        dataTask.resume()
    }
}


class requestModel: NSObject {
    var num = 0
    var rand = 0
    var word = ""
    var page = 0
    var src = ""
}
