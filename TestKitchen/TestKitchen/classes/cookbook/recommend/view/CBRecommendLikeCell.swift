//
//  CBRecommendLikeCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRecommendLikeCell: UITableViewCell {
    
    var model:CBRecommendWidgetListModel?{
        didSet{
            showData()
        }
    }
    
    func showData(){
        for var i in 0..<8{
            if model?.widget_data?.count > i{
                let imageModel = model?.widget_data![i]
                if imageModel?.type == "image"{
                    let subView = viewWithTag(200 + i / 2)
                    if ((subView?.isKindOfClass(UIImageView.self)) == true){
                        let imageView = subView as! UIImageView
                        let url = NSURL(string: (imageModel?.content)!)
                        imageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }
            if model?.widget_data?.count > i + 1{
                let textModel = model?.widget_data![i+1]
                if textModel?.type == "text"{
                    let subView = viewWithTag(300 + i / 2)
                    if ((subView?.isKindOfClass(UILabel.self)) == true){
                        let label = subView as! UILabel
                        label.text = (textModel?.content)!
                    }
                }
            }
            i += 1
        }
  
    }
    class func createLikeCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendWidgetListModel)->CBRecommendLikeCell{
        let cellId = "recommendLikeCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendLikeCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendLikeCell", owner: nil, options: nil).last as? CBRecommendLikeCell
        }
        cell?.model = listModel
        return cell!
    }
    

    @IBAction func clickBtn(sender: UIButton) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
