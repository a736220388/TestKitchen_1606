//
//  KTCSegmentCtrl.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
protocol KTCSegmentCtrlDelegate:NSObjectProtocol {
    func didSelectSegCtrl(segCtrl:KTCSegmentCtrl,atIndex index:Int)
}

class KTCSegmentCtrl: UIView {
    
    weak var delegate:KTCSegmentCtrlDelegate?
    var selectedIndex:Int = 0{
        didSet{
            if selectedIndex != oldValue{
                selectBtnAtIndex(selectedIndex,lastIndex: oldValue)
            }
        }
    }
    func selectBtnAtIndex(index:Int,lastIndex:Int){
        let curBtn = viewWithTag(300+index)
        if curBtn?.isKindOfClass(KTCSegmentBtn.self) == true{
            let btn = curBtn as! KTCSegmentBtn
            btn.clicked = true
        }
        let lastBtn = viewWithTag(300 + lastIndex)
        if lastBtn?.isKindOfClass(KTCSegmentBtn.self) == true{
            let lastSegBtn = lastBtn as! KTCSegmentBtn
            lastSegBtn.clicked = false
        }
        lineView?.frame.origin.x = (lineView?.bounds.size.width)! * CGFloat(selectedIndex)
    }
    private var lineView:UIView?

    init(frame: CGRect,titleNames:[String]) {
        super.init(frame: frame)
        if titleNames.count > 0{
            let width = bounds.size.width / CGFloat(titleNames.count)
            for i in 0..<titleNames.count{
                let frame = CGRectMake(width*CGFloat(i), 0, width, bounds.size.height)
                let btn = KTCSegmentBtn(frame: frame)
                addSubview(btn)
                btn.tag = 300 + i
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                btn.configTitle(titleNames[i])
                if i == 0{
                    btn.clicked = true
                }
            }
            lineView = UIView.createView()
            lineView?.backgroundColor = UIColor.orangeColor()
            lineView?.frame = CGRectMake(0, bounds.size.height - 2, width, 2)
            addSubview(lineView!)
        }
    }
    func clickBtn(btn:KTCSegmentBtn){
        if btn.tag != 300 + selectedIndex{
            //selectBtnAtIndex(btn.tag - 300)
            selectedIndex = btn.tag - 300
            delegate?.didSelectSegCtrl(self, atIndex: selectedIndex)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class KTCSegmentBtn: UIControl {
    private var label:UILabel?
    var clicked:Bool?{
        didSet{
            if clicked == true{
                label?.textColor = UIColor.blackColor()
            }else if clicked == false{
                label?.textColor = UIColor.grayColor()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(20), textAlignment: .Center, textColor: UIColor.grayColor())
        label?.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 10)
        addSubview(label!)
    }
    
    func configTitle(title:String){
        label?.text = title
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}