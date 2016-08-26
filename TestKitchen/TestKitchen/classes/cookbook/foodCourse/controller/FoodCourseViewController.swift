//
//  FoodCourseViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class FoodCourseViewController: BaseViewController {
    
    var seriesId:String?
    
    private var tbView:UITableView?
    
    private var serialModel:FoodCourseModel?
    
    private var serialIndex:Int = 0
    
    //集数是否展开
    private var serialIsExpand:Bool = false
    
    //评论数据的当前页数
    private var curPage:Int = 1
    //评论数据
    private var commentModel:FCComment?
    
    //是否有更多数据
    private var infoLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createMyNav()
        createTableView()
        downloadFoodCourseData()
        downloadCommentData()
    }
    func downloadFoodCourseData(){
        var dict = Dictionary<String,String>()
        dict["methodName"] = "CourseSeriesView"
        dict["series_id"] = seriesId
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .FoodCourse
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    func createMyNav(){
        addNavBackBtn()
    }
    func createTableView(){
        automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight-64), style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        view.addSubview(tbView!)
    }
    func downloadCommentData(){
        var params = Dictionary<String,String>()
        params["methodName"] = "CommentList"
        params["page"] = "\(curPage)"
        params["relate_id"] = seriesId
        params["size"] = "10"
        params["type"] = "2"
        let downloader = KTCDownloader()
        downloader.type = .FoodCourseComment
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: params)
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
extension FoodCourseViewController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if downloader.type == .FoodCourse{
            if let jsonData = data{
                let model = FoodCourseModel.parseModelWithData(jsonData)
                serialModel = model
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.tbView?.reloadData()
                    let array = self!.serialModel?.data?.series_name?.componentsSeparatedByString("#")
                    if array?.count > 1{
                        self!.addNavTitle((array?[1])!)
                    }
                })
            }
        }else if downloader.type == .FoodCourseComment{
            if let jsonData = data{
                let model = FCComment.parseWithData(jsonData)
                if curPage == 1{
                    commentModel = model
                }else{
                    if (commentModel?.data?.data) != nil{
                        let mutableArray = NSMutableArray(array: (commentModel?.data?.data)!)
                        mutableArray.addObject((commentModel?.data?.data)!)
                        let array = NSArray(array: mutableArray)
                        commentModel?.data?.data = array as? [FCCommentDetail]
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                var hasMore = false
                if self!.commentModel?.data?.total != nil{
                    let total = NSString(string: (self!.commentModel?.data?.count)!).integerValue
                    if total > self!.commentModel?.data?.data?.count{
                        hasMore = true
                    }
                }
                if self!.infoLabel == nil{
                    self!.infoLabel = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(16), textAlignment: .Center, textColor: UIColor.blackColor())
                    self!.infoLabel?.frame = CGRectMake(0, 0, kScreenWidth, 40)
                    self!.tbView?.tableFooterView = self?.infoLabel
                }
                if hasMore{
                    self?.infoLabel?.text = "下拉加载更多"
                }else{
                    self?.infoLabel?.text = "没有更多了"
                }
                self!.tbView?.reloadData()
            })
        }
    }
}

extension FoodCourseViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0{
            if serialModel?.data?.data?.count > 0{
                rowNum = 3
            }
        }else if section == 1{
            //评论
            if commentModel?.data?.data?.count > 0{
                rowNum = (commentModel?.data?.data?.count)!
            }
        }
        return rowNum
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{
            if indexPath.row == 0{
                height = 160
            }else if indexPath.row == 1{
                if serialModel?.data?.data?.count > 0{
                    let model = serialModel?.data?.data![serialIndex]
                    height = FCCourseCell.heightWithModel(model!)
                }
            }else if indexPath.row == 2{
                height = FCSerialCell.heightWithNum((serialModel?.data?.data?.count)!,isExpand: serialIsExpand)
            }
        }else if indexPath.section == 1{
            height = 80
        }
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0{
            let dataModel = serialModel?.data?.data![serialIndex]
            if indexPath.row == 0{
                cell = createVideoCellFor(tableView, atIndexPath: indexPath, withModel: dataModel!)
            }else if indexPath.row == 1{
                cell = createCourseCellFor(tableView, atIndexPath: indexPath, withModel: dataModel!)
            }else if indexPath.row == 2{
                cell = createSerialCellFor(tableView, atIndexPath: indexPath, withModel: serialModel!)
            }
        }else if indexPath.section == 1{
            let detailModel = commentModel?.data?.data![indexPath.row]
            cell = createCommentCellFor(tableView, atIndexPath: indexPath, withModel: detailModel!)
        }
        cell.selectionStyle = .None
        return cell
    }
    //创建视频的cell
    func createVideoCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel)->FCVideoCell{
        let cellId = "videoCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCVideoCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
        }
        cell?.videoClosure = {
            urlString in
            let url = NSURL(string: urlString)
            let player = AVPlayer(URL: url!)
            let playerCtrl = AVPlayerViewController()
            playerCtrl.player = player
            player.play()
            self.presentViewController(playerCtrl, animated: true, completion: nil)
        }
        cell!.model = model
        return cell!
    }
    //创建课程和描述的cell
    func createCourseCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel)->FCCourseCell{
        let cellId = "courseCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCCourseCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FCCourseCell", owner: nil, options: nil).last as? FCCourseCell
        }
        cell?.model = model
        return cell!
    }
    //创建课程和描述的cell
    func createSerialCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseModel)->FCSerialCell{
        let cellId = "serialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSerialCell
        if cell == nil{
            cell = FCSerialCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.isExpand = serialIsExpand
        cell?.num = model.data?.data!.count
        cell?.selectIndex = serialIndex
        cell?.delegate = self
        return cell!
    }
    //创建评论的cell
    func createCommentCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel detailModel:FCCommentDetail)->FCCommentCell{
        let cellId = "commentCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCCommentCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FCCommentCell", owner: nil, options: nil).last as? FCCommentCell
        }
        cell?.model = detailModel
        return cell!
    }
    //加载更多
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if commentModel?.data?.total != nil{
            let total = NSString(string: (commentModel?.data?.total)!).integerValue
            if total == commentModel?.data?.data?.count{
                return
            }
        }
        
        let offset:CGFloat = 40
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height - offset{
            curPage += 1
            downloadCommentData()
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1{
            let bgView = UIView.createView()
            bgView.frame = CGRectMake(0, 0, kScreenWidth, 60)
            bgView.backgroundColor = UIColor.whiteColor()
            if commentModel?.data?.total != nil{
                let str = "\((commentModel?.data?.total)!)条评论"
                let numLabel = UILabel.createLabel(str, font: UIFont.systemFontOfSize(17), textAlignment: .Left, textColor: UIColor.grayColor())
                numLabel.frame = CGRectMake(20, 4, 160, 20)
                bgView.addSubview(numLabel)
            }
            let btn = UIButton.createBtn("我要评论", bgImageName: nil, selectBgImageName: nil, target: self, action: #selector(commentAction))
            btn.backgroundColor = UIColor.orangeColor()
            btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            btn.layer.cornerRadius = 6
            btn.clipsToBounds = true
            bgView.addSubview(btn)
            btn.frame = CGRectMake(20, 30, kScreenWidth-20*2, 30)
            return bgView
        }
        return nil
    }
    func commentAction(){
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 70
        }
        return 0
    }
}
extension FoodCourseViewController:FCSerialCellDelegate{
    func didSelectedAtIndex(index: Int) {
        serialIndex = index
        //刷新某一个section
        tbView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    func changeExpandState(isExpand: Bool) {
        serialIsExpand = isExpand
        tbView?.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Automatic)
    }
}


