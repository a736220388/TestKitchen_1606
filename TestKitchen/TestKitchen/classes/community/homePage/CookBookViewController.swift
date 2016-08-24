//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CookBookViewController: BaseViewController {
    
    var scrollView:UIScrollView?
    
    private var recommendView:CBRecommendView?
    
    private var foodView:CBMaterialView?
    
    private var categoryView:CBMaterialView?
    
    private var segCtrl:KTCSegmentCtrl?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createMyNav()
        createHomePageView()
        downloadRecommendData()
        downloadFoodData()
        downloadCategoryData()
    }
    func downloadCategoryData(){
        let params = ["methodName":"CategoryIndex"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .Category
        downloader.postWithUrl(kHostUrl, params: params)
    }
    func downloadFoodData(){
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = KTCDownloaderType.FoodMaterial
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    
    func createHomePageView(){
        automaticallyAdjustsScrollViewInsets = false
        //推荐,食材,分类的滚动视图
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        scrollView!.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView!)
            make.height.equalTo(self!.scrollView!)
        }
        
        recommendView = CBRecommendView()
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
        })
        
        foodView = CBMaterialView()
        foodView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(foodView!)
        foodView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        
        categoryView = CBMaterialView()
        categoryView?.backgroundColor = UIColor.yellowColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((foodView?.snp_right)!)
        })
        
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo((categoryView?.snp_right)!)
        }
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
    }
    func downloadRecommendData(){
        let dict = ["methodName":"SceneHome"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = KTCDownloaderType.Recommend
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    func createMyNav(){
        segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kScreenWidth-80*2, 44 ), titleNames: ["推荐","食材","分类"])
        segCtrl?.delegate = self
        navigationItem.titleView = segCtrl
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
        if downloader.type == .Recommend{
            if let jsonData = data{
                let model = CBRecommendModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.recommendView?.model = model
                })
            }
        }else if downloader.type == .FoodMaterial{
            if let jsonData = data{
                let model = CBMaterialModel.parseModelWithData(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.foodView?.model = model
                })
            }
        }else if downloader.type == .Category{
            if let jsonData = data{
                let model = CBMaterialModel.parseModelWithData(jsonData)
                dispatch_async(dispatch_get_main_queue(), { 
                    [weak self] in
                    self?.categoryView?.model = model
                })
            }
        }
    }
}
extension CookBookViewController:KTCSegmentCtrlDelegate{
    func didSelectSegCtrl(segCtrl: KTCSegmentCtrl, atIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(kScreenWidth*CGFloat(index), 0), animated: true)
    }
}
extension CookBookViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        segCtrl?.selectedIndex = index
    }
}
