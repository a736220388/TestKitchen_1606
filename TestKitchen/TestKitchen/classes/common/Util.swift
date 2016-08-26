
//
//  Util.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

public enum WidgetType:Int{
    case GuessYourLike = 1
    case RedPackage = 2
    case Special = 3
    case NewProduct = 5
    case Scene = 9
    case Talent = 4
    case Works = 8
    case Subject = 7
}

public typealias CBCellClosure = (String?,String)->Void