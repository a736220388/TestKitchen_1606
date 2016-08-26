//
//  FCSerialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol FCSerialCellDelegate:NSObjectProtocol {
    func didSelectedAtIndex(index:Int)
    func changeExpandState(isExpand:Bool)
}

class FCSerialCell: UITableViewCell {
    
    private var btnW:CGFloat{
        get{
            return 40
        }
    }
    private var btnH:CGFloat{
        get{
            return 40
        }
    }
    private var margin:CGFloat{
        get{
            return 20
        }
    }
    private var spaceY:CGFloat{
        get{
            return 20
        }
    }
    private var rowBtnNum:Int{
        get{
            return Int((kScreenWidth - margin*2)/btnW)
        }
    }
    private var spaceX:CGFloat{
        get{
            return (kScreenWidth - margin*2 - CGFloat(rowBtnNum)*btnW)/(CGFloat(rowBtnNum) - 1)
        }
    }
    private var moreBtnW:CGFloat{
        get{
            return 40
        }
    }
    private var moreBtnH:CGFloat{
        get{
            return 30
        }
    }
    weak var delegate:FCSerialCellDelegate?
    //更多按钮
    private var moreBtn:UIButton?
    var isExpand:Bool = false
    
    var selectIndex:Int = 0{
        didSet{
            selectBtnAtIndex(selectIndex, lastIndex: oldValue)
        }
    }
    
    var num:Int?{
        didSet{
            if num > 0{
                showData()
            }
        }
    }
    func showData(){
        for oldSub in contentView.subviews{
            oldSub.removeFromSuperview()
        }
        var cnt = num!
        if num>rowBtnNum*2{
            if !isExpand{
                cnt = rowBtnNum*2
            }
        }
        for i in 0..<cnt {
            let row = i / rowBtnNum
            let col = i % rowBtnNum
            let frame = CGRectMake(margin+CGFloat(col)*(btnW+spaceX), spaceY+CGFloat(row)*(btnH+spaceY), btnW, btnH)
            let btn = FCSerialBtn(frame: frame, index: i+1)
            btn.tag = 500 + i
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            contentView.addSubview(btn)
        }
        //判断是否显示展开按钮
        if num > rowBtnNum*2{
            var btnRow = 2
            var imageName = "pull.png"
            if isExpand{
                imageName = "push.png"
                btnRow = num!/rowBtnNum
                if num! % rowBtnNum > 0{
                    btnRow += 1
                }
            }
            moreBtn = UIButton.createBtn(nil, bgImageName: imageName, selectBgImageName: nil, target: self, action: #selector(expandAction))
            moreBtn?.frame = CGRectMake((kScreenWidth - moreBtnW*2)/2, margin+(btnH+spaceY)*CGFloat(btnRow), moreBtnW, moreBtnH)
            contentView.addSubview(moreBtn!)
        }
    }
    func expandAction(){
        delegate?.changeExpandState(!isExpand)
    }
    func selectBtnAtIndex(index:Int,lastIndex:Int){
        let lastBtn = contentView.viewWithTag(500+lastIndex)
        if lastBtn?.isKindOfClass(FCSerialBtn.self) == true{
            let btn = lastBtn as! FCSerialBtn
            btn.clicked = false
        }
        let curBtn = contentView.viewWithTag(500+index)
        if curBtn?.isKindOfClass(FCSerialBtn.self) == true{
            let btn = curBtn as! FCSerialBtn
            btn.clicked = true
        }
    }
    func clickBtn(btn:FCSerialBtn){
        selectIndex = btn.tag - 500
        delegate?.didSelectedAtIndex(selectIndex)
    }
    
    class func heightWithNum(num:Int,isExpand:Bool)->CGFloat{
        let cell = FCSerialCell()
        var rows = num/cell.rowBtnNum
        if num%cell.rowBtnNum > 0{
            rows += 1
        }
        if num > cell.rowBtnNum*2 && !isExpand{
            rows = 2
        }
        var h = cell.margin + CGFloat(rows)*(cell.btnH+cell.spaceY)+cell.margin
        if num > cell.rowBtnNum*2{
            h += cell.moreBtnW + cell.margin
        }
        return h
    }

}

class FCSerialBtn: UIControl {
    var titleLabel:UILabel?
    var clicked:Bool = false{
        didSet{
            if clicked == true{
                backgroundColor = UIColor.orangeColor()
                titleLabel?.textColor = UIColor.whiteColor()
            }else if clicked == false{
                backgroundColor = UIColor(white: 0.9, alpha: 1.0)
                titleLabel?.textColor = UIColor.grayColor()
            }
        }
    }
    init(frame: CGRect,index:Int) {
        super.init(frame: frame)
        titleLabel = UILabel.createLabel("\(index)", font: UIFont.systemFontOfSize(12), textAlignment: .Center, textColor: UIColor.grayColor())
        titleLabel?.frame = bounds
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
