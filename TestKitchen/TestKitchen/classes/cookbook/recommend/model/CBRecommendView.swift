//
//  CBRecommendView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRecommendView: UIView{

    var clickClosure:CBCellClosure?
    
    private var tbView:UITableView?
    var model:CBRecommendModel?{
        didSet{
            tbView?.reloadData()
        }
    }
    init(){
        super.init(frame: CGRectZero)
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        addSubview(tbView!)
        
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CBRecommendView:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sectionNum = 1
        if model?.data?.widgetList?.count > 0{
            sectionNum += (model?.data?.widgetList?.count)!
        }
        return sectionNum
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0{
            if model?.data?.banner?.count > 0{
                rowNum = 1
            }
        }else{
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYourLike.rawValue{
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgetType.RedPackage.rawValue{
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgetType.NewProduct.rawValue{
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgetType.Special.rawValue{
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgetType.Scene.rawValue{
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgetType.Talent.rawValue{
                rowNum = (listModel?.widget_data?.count)! / 4
            }else if listModel?.widget_type?.integerValue == WidgetType.Works.rawValue{
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgetType.Subject.rawValue{
                rowNum = (listModel?.widget_data?.count)! / 3
            }
        }
        return rowNum
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{
            if model?.data?.banner?.count > 0{
                height = 120
            }
        }else{
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYourLike.rawValue{
                height = 80
            }else if listModel?.widget_type?.integerValue == WidgetType.RedPackage.rawValue{
                height = 70
            }else if listModel?.widget_type?.integerValue == WidgetType.NewProduct.rawValue{
                height = 220
            }else if listModel?.widget_type?.integerValue == WidgetType.Special.rawValue{
                height = 200
            }else if listModel?.widget_type?.integerValue == WidgetType.Scene.rawValue{
                height = 60
            }else if listModel?.widget_type?.integerValue == WidgetType.Talent.rawValue{
                height = 80
            }else if listModel?.widget_type?.integerValue == WidgetType.Works.rawValue{
                height = 240
            }else if listModel?.widget_type?.integerValue == WidgetType.Subject.rawValue{
                height = 180
            }
        }
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0{
            if model?.data?.banner?.count > 0{
                cell = CBRecommendADCell.createAdCellFor(tableView, atIndexPath: indexPath, withModel: model!,cellClosure: clickClosure)
            }
        }else{
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYourLike.rawValue{
                cell = CBRecommendLikeCell.createLikeCell(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.RedPackage.rawValue{
                cell = CBRedPacketCell.createRedPackageCell(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.NewProduct.rawValue{
                cell = CBRecommendNewCell.createNewCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.Special.rawValue{
                cell = CBSpecialCell.createCBSpecialCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.Scene.rawValue{
                cell = CBSenceCell.createSceneCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.Talent.rawValue{
                cell = CBTalentCell.createCBTalentCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.Works.rawValue{
                cell = CBWorksCell.createWorksCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.Subject.rawValue{
                cell = CBSubjectCell.createSubjectCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }
        }
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView:UIView? = nil
        if section > 0{
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYourLike.rawValue{
                headerView = CBSearchHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
                headerView?.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            }else if listModel?.widget_type?.integerValue == WidgetType.NewProduct.rawValue || listModel?.widget_type?.integerValue == WidgetType.Special.rawValue || listModel?.widget_type?.integerValue == WidgetType.Talent.rawValue || listModel?.widget_type?.integerValue == WidgetType.Works.rawValue || listModel?.widget_type?.integerValue == WidgetType.Subject.rawValue{
                let tmpView = CBHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
                tmpView.configTitle((listModel?.title)!)
                headerView = tmpView
            }
        }
        return headerView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height:CGFloat = 0
        if section > 0{
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYourLike.rawValue || listModel?.widget_type?.integerValue == WidgetType.NewProduct.rawValue || listModel?.widget_type?.integerValue == WidgetType.Special.rawValue || listModel?.widget_type?.integerValue == WidgetType.Talent.rawValue || listModel?.widget_type?.integerValue == WidgetType.Works.rawValue || listModel?.widget_type?.integerValue == WidgetType.Subject.rawValue{
                height = 44
            }
        }
        return height
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h:CGFloat = 44
        if scrollView.contentOffset.y > h{
            scrollView.contentInset = UIEdgeInsetsMake(-h, 0, 0, 0)
        }else if scrollView.contentOffset.y > 0{
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
    }
    
}
