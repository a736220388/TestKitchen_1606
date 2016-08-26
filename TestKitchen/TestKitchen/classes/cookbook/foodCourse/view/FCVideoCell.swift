//
//  FCVideoCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FCVideoCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBAction func playAction(sender: UIButton) {
        videoClosure!((model?.course_video)!)
    }
    @IBOutlet weak var titleLabel: UILabel!
    var videoClosure:(String->Void)?
    var model:FoodCourseSerialModel?{
        didSet{
            if model != nil{
            let url = NSURL(string: model!.course_image!)
            bgImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            titleLabel.text = String(format: "%d人做过", (model?.video_watchcount)!)
            }
        }
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
