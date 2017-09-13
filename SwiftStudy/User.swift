//
//  File.swift
//  SwiftStudy
//
//  Created by xiejinke on 2016/11/15.
//  Copyright © 2016年 wy. All rights reserved.
//

import Foundation
import UIKit

protocol UserProtocol {

    var name:String {get set}
    
    
    
}

extension UserProtocol {
    func walk(count c:Int) {
        print("userProtocol...")
    }
}

class Logger {
    class func log(item: Any, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
        print(file + ":\(line):" + function, item)
    }
}


extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x:0, y:0, width:reSize.width, height:reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width:self.size.width * scaleSize,height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}

