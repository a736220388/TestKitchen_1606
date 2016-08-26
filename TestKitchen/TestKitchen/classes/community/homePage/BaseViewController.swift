//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func addNavTitle(title:String){
        let titleLabel = UILabel.createLabel(title, font: UIFont.systemFontOfSize(24), textAlignment: .Center, textColor: UIColor.blueColor())
        titleLabel.frame = CGRectMake(80, 0, kScreenWidth-80*2, 44)
        navigationItem.titleView = titleLabel
    }
    func addNavBtn(imageName:String,target:AnyObject?,action:Selector,isLeft:Bool){
        let btn = UIButton.createBtn(nil, bgImageName: imageName, selectBgImageName: nil, target: target, action: action)
        let barBtnItem = UIBarButtonItem(customView: btn)
        btn.frame = CGRectMake(0, 4, 30, 36)
        if isLeft{
            navigationItem.leftBarButtonItem = barBtnItem
        }else{
            navigationItem.rightBarButtonItem = barBtnItem
        }
    }
    func addNavBackBtn(){
        addNavBtn("nav_back_black", target: self, action: #selector(backAction), isLeft: true)
    }
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
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
