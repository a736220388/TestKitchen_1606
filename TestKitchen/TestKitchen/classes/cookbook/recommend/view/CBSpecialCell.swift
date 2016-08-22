//
//  CBSpecialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBSpecialCell: UITableViewCell {
    
    private var model:CBRecommendWidgetListModel?{
        didSet{
            showData()
        }
    }
    func showData(){
        if model?.widget_data?.count > 0{
            let imageModel = model?.widget_data![0]
            if imageModel?.type == "image"{
                let subView = contentView.viewWithTag(100)
                if ((subView?.isKindOfClass(UIButton.self)) == true){
                    let sceneBtn = subView as! UIButton
                    let url = NSURL(string: (imageModel?.content)!)
                    let image = UIImage(named: "sdefaultImage")
                    sceneBtn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
        if model?.widget_data?.count>1{
            let nameModel = model?.widget_data![1]
            if nameModel?.type == "text"{
                let subView = contentView.viewWithTag(101)
                if ((subView?.isKindOfClass(UILabel.self)) == true){
                    let nameLabel = subView as! UILabel
                    nameLabel.text = (nameModel?.content)!
                }
            }
        }
        if model?.widget_data?.count > 2{
            let numModel = model?.widget_data![2]
            if numModel?.type == "text"{
                let subView = contentView.viewWithTag(102)
                if ((subView?.isKindOfClass(UILabel.self)) == true){
                    let numLabel = subView as! UILabel
                    numLabel.text = (numModel?.content)!
                }
            }
        }
        for i in 0..<4{
            let index = i*2+3
            if model?.widget_data?.count>index{
                let imageModel = model?.widget_data![index]
                if imageModel?.type == "image"{
                    let subView = contentView.viewWithTag(200+i)
                    if subView?.isKindOfClass(UIButton.self) == true{
                        let btn = subView as! UIButton
                        btn.kf_setBackgroundImageWithURL(NSURL(string: (imageModel?.content)!), forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }
        }
        let subView = contentView.viewWithTag(400)
        if subView?.isKindOfClass(UILabel.self)==true{
            let label = subView as! UILabel
            label.text = (model?.desc)!
        }
        
    }

    @IBAction func clickSceneBtn(sender: UIButton) {
    }
    @IBAction func clickDetailBtn(sender: UIButton) {
    }
    @IBAction func clickPlayBtn(sender: UIButton) {
    }
    
    class func createCBSpecialCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendWidgetListModel)->CBSpecialCell{
        let cellId = "specialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBSpecialCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CBSpecialCell", owner: nil, options: nil).last as? CBSpecialCell
        }
        cell?.model = listModel
        return cell!
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
