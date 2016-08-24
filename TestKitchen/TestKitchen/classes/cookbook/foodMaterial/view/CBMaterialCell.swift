//
//  CBMaterialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBMaterialCell: UITableViewCell {
    
    var model:CBMaterialTypeModel?{
        didSet{
            if model != nil{
                showData()
            }
        }
    }
    func showData(){
        for oldSub in contentView.subviews{
            oldSub.removeFromSuperview()
        }
        let titleLabel = UILabel.createLabel(model!.text, font: UIFont.systemFontOfSize(20), textAlignment: .Left, textColor: UIColor.blackColor())
        titleLabel.frame = CGRectMake(20, 0, kScreenWidth-20*2, 40)
        contentView.addSubview(titleLabel)
        let spaceX:CGFloat = 10
        let spaceY:CGFloat = 10
        let colNum:CGFloat = 5
        let h:CGFloat = 40
        let w:CGFloat = (kScreenWidth - spaceX*(colNum+1))/colNum
        let offsetY:CGFloat = 40
        let imageFrame = CGRectMake(spaceX, offsetY, 2*w+spaceX, h*2+spaceY)
        let imageView = UIImageView.createImageView(nil)
        imageView.frame = imageFrame
        let url = NSURL(string: (model?.image)!)
        imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(imageView)
        
        if model?.data?.count > 0{
            let cnt = model?.data?.count
            for i in 0..<cnt!{
                var btnFrame = CGRectZero
                if i < 6{
                    let row = CGFloat(i/3)
                    let col = CGFloat(i%3)
                    btnFrame = CGRectMake(w*2+spaceY*3+col*(w+spaceX), offsetY+row*(h+spaceY), w, h)
                }else{
                    let row = CGFloat((i-6)/5)
                    let col = CGFloat((i-6)%5)
                    btnFrame = CGRectMake(spaceX + col*(w+spaceX), offsetY+2*(h+spaceY)+row*(h+spaceY), w, h)
                }
                let btn = CBMaterialBtn(frame: btnFrame)
                btn.model = model?.data![i]
                contentView.addSubview(btn)
            }
        }
    }
    class func heightWithModel(model:CBMaterialTypeModel)->CGFloat{
        var h:CGFloat = 0
        let offsetY:CGFloat = 40
        let spaceY:CGFloat = 10
        let btnH:CGFloat = 40
        if model.data?.count > 0{
            if model.data?.count < 6{
                h = offsetY + (btnH+spaceY)*2
            }else{
                var rowNum = ((model.data?.count)! - 6)/5
                if ((model.data?.count)! - 6)%5 > 0{
                    rowNum += 1
                }
                h = offsetY + (btnH+spaceY)*2 + CGFloat(rowNum)*(btnH+spaceY)
            }
        }
        return h
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
class CBMaterialBtn: UIControl {
    private var titleLabel:UILabel?
    var model:CBMaterialSubtypeModel?{
        didSet{
            titleLabel?.text = model?.text
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        titleLabel = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(15), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.numberOfLines = 2
        titleLabel!.frame = bounds
        titleLabel?.textColor = UIColor(white: 0.3, alpha: 1.0)
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}