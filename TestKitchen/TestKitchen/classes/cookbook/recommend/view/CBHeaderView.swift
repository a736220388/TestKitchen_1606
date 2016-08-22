//
//  CBHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBHeaderView: UIView {
    
    private var titleLabel:UILabel?
    private var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        let bgView = UIView.createView()
        bgView.frame = CGRectMake(0, 10, bounds.size.width, bounds.size.height - 10)
        bgView.backgroundColor = UIColor.whiteColor()
        addSubview(bgView)
        
        let titleW:CGFloat = 140
        let imageW:CGFloat = 24
        let x = (bounds.size.width - titleW - imageW)/2
        titleLabel = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(18), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.frame = CGRectMake(x, 10, titleW, bounds.size.height - 10)
        addSubview(titleLabel!)
        
        imageView = UIImageView.createImageView("more_icon")
        imageView?.frame = CGRectMake(x+titleW, 16, imageW, imageW)
        addSubview(imageView!)
    }
    
    func configTitle(title:String){
        titleLabel?.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
