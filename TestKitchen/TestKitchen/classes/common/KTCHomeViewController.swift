//
//  KTCHomeViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class KTCHomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        let mainTabbarCtrl = ctrl as! MainTabBarController
        mainTabbarCtrl.showTabbar()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        let mainTabbarCtrl = ctrl as! MainTabBarController
        mainTabbarCtrl.showTabbar()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        let mainTabbarCtrl = ctrl as! MainTabBarController
        mainTabbarCtrl.hideTabbar()
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
