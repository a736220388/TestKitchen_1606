//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CookBookViewController: BaseViewController {
    
    private var recommendView:CBRecommendView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createMyNav()
        createHomePageView()
        downloadRecommendData()
    }
    func createHomePageView(){
        automaticallyAdjustsScrollViewInsets = false
        recommendView = CBRecommendView()
        view.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo((self?.view)!).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
    }
    func downloadRecommendData(){
        let dict = ["methodName":"SceneHome","token":"","user_id":"","version":"4.32"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    func createMyNav(){
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
    }
    func scanAction(){
        
    }
    func searchAction(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CookBookViewController : KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if let jsonData = data{
            let model = CBRecommendModel.parseModel(jsonData)
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                self!.recommendView?.model = model
            })
        }
    }
}
