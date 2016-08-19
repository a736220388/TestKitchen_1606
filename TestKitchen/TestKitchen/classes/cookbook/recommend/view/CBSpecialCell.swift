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
    }

    @IBAction func clickSceneBtn(sender: UIButton) {
    }
    @IBAction func clickDetailBtn(sender: UIButton) {
    }
    @IBAction func clickPlayBtn(sender: UIButton) {
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
