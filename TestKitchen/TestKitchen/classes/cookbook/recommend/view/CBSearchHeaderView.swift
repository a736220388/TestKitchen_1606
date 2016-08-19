//
//  CBSearchHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBSearchHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let searchBar = UISearchBar(frame: CGRectMake(30,8,bounds.size.width - 30*2,bounds.size.height-16))
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.placeholder = "输入菜名或食材搜索"
        searchBar.layer.cornerRadius = 15
        searchBar.clipsToBounds = true
//        searchBar.alpha = 0.5
        addSubview(searchBar)
        
//        let textField = UITextField(frame: CGRectMake(40,4,bounds.size.width-40*2,bounds.size.height-4*2))
//        textField.placeholder = "输入菜名或食材搜索"
//        textField.borderStyle = .RoundedRect
//        let imageView = UIImageView.createImageView("search")
//        imageView.frame = CGRectMake(0, 0, 24, 24)
//        textField.leftView = imageView
//        textField.leftViewMode = .Always
//        addSubview(textField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
