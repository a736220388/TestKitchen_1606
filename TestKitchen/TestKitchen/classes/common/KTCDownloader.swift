//
//  KTCDownloader.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import Alamofire
public enum KTCDownloaderType:Int{
    case Default = 10
    case Recommend     //食材首页推荐
    case FoodMaterial  //首页食材
    case Category      //首页分类
    case FoodCourse    //食材课程
    case FoodCourseComment  //食材课程的评论
}
protocol KTCDownloaderDelegate:NSObjectProtocol {
    func downloader(downloader:KTCDownloader,didFailWithError error:NSError)
    func downloader(downloader:KTCDownloader,didFinishWithData data:NSData?)
}
class KTCDownloader: NSObject {
    var type:KTCDownloaderType = .Default
    weak var delegate:KTCDownloaderDelegate?
    func postWithUrl(urlString:String,params:Dictionary<String,String>){
        var newParam = params
        newParam["token"] = ""
        newParam["user_id"] = ""
        newParam["version"] = "4.5"
        Alamofire.request(.POST, urlString, parameters: newParam, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
                case .Failure(let error):
                    self.delegate?.downloader(self, didFailWithError: error)
                case .Success:
                    self.delegate?.downloader(self, didFinishWithData: response.data)
            }
        }
    }
}

