//
//  FCCourseCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FCCourseCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var heightCon: NSLayoutConstraint!
    var model:FoodCourseSerialModel?{
        didSet{
            showData()
        }
    }
    func showData(){
        nameLabel.text = model?.course_name!
        subjectLabel.text = model?.course_subject!
        if model?.course_subject != nil{
            let dict = [NSFontAttributeName:UIFont.systemFontOfSize(17)]
            let h = NSString(string: (model?.course_subject)!).boundingRectWithSize(CGSizeMake(kScreenWidth-20*2, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
            //有一点点误差
            heightCon.constant = CGFloat(Int(h)+1)
        }
    }
    //计算文字cell的高度的方法
    class func heightWithModel(model:FoodCourseSerialModel)->CGFloat{
        let titleH:CGFloat = 20
        let marginY:CGFloat = 10
        let dict = [NSFontAttributeName:UIFont.systemFontOfSize(17)]
        var height:CGFloat = marginY + titleH + marginY
        if model.course_subject != nil{
            let h = NSString(string: model.course_subject!).boundingRectWithSize(CGSizeMake(kScreenWidth-20*2, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
            height += (CGFloat(Int(h)+1)+marginY)
        }
        return height
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
